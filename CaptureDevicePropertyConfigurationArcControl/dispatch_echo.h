//
//  dispatch_echo.h
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/18/21.
//

#ifndef dispatch_echo_h
#define dispatch_echo_h


#import "echo.h"
#include <sys/socket.h> // AF_INET, AF_INET6
#include <netinet/in.h>

in_port_t port = 10000;
static void (^DieWithError)(char *) = ^ (char *errorMessage) {
    printf("\nError:\t\%s\n", errorMessage);
};

// Returns a block you can call later to shut down the server -- caller owns block.
dispatch_block_t CreateCleanupBlockForLaunchedServer(void)
{
    // Create the socket
    int servSock = -1;
    if ((servSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
        DieWithError("socket() failed");
    }

    // Bind the socket - if the port we want is in use, increment until we find one that isn't
    struct sockaddr_in echoServAddr;
    memset(&echoServAddr, 0, sizeof(echoServAddr));
    echoServAddr.sin_family = AF_INET;
    echoServAddr.sin_addr.s_addr = htonl(INADDR_ANY);
    do {
        printf("server attempting to bind to port %d", (int)port);
        echoServAddr.sin_port = htons(port);
    } while (bind(servSock, (struct sockaddr *) &echoServAddr, sizeof(echoServAddr)) < 0 && ++port);

    // Make the socket non-blocking
    if (fcntl(servSock, F_SETFL, O_NONBLOCK) < 0) {
        shutdown(servSock, SHUT_RDWR);
        close(servSock);
        DieWithError("fcntl() failed");
    }

    // Set up the dispatch source that will alert us to new incoming connections
    dispatch_queue_t q = dispatch_queue_create("server_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_source_t acceptSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, servSock, 0, q);
    dispatch_source_set_event_handler(acceptSource, ^{
        const unsigned long numPendingConnections = dispatch_source_get_data(acceptSource);
        for (unsigned long i = 0; i < numPendingConnections; i++) {
            int clntSock = -1;
            struct sockaddr_in echoClntAddr;
            unsigned int clntLen = sizeof(echoClntAddr);

            // Wait for a client to connect
            if ((clntSock = accept(servSock, (struct sockaddr *) &echoClntAddr, &clntLen)) >= 0)
            {
                printf("server sock: %d accepted", clntSock);

                dispatch_io_t channel = dispatch_io_create(DISPATCH_IO_STREAM, clntSock, q, ^(int error) {
                    if (error) {
                        fprintf(stderr, "Error: %s", strerror(error));
                    }
                    printf("server sock: %d closing", clntSock);
                    close(clntSock);
                });

                // Configure the channel...
                dispatch_io_set_low_water(channel, 1);
                dispatch_io_set_high_water(channel, SIZE_MAX);

                // Setup read handler
                dispatch_io_read(channel, 0, SIZE_MAX, q, ^(bool done, dispatch_data_t data, int error) {
                    BOOL close = NO;
                    if (error) {
                        fprintf(stderr, "Error: %s", strerror(error));
                        close = YES;
                    }

                    const size_t rxd = data ? dispatch_data_get_size(data) : 0;
                    if (rxd) {
                        // echo...
                        printf("server sock: %d received: %ld bytes", clntSock, (long)rxd);
                        // write it back out; echo!
                        dispatch_io_write(channel, 0, data, q, ^(bool done, dispatch_data_t data, int error) {});
                    }
                    else {
                        close = YES;
                    }

                    if (close) {
                        dispatch_io_close(channel, DISPATCH_IO_STOP);
//                        dispatch_release(channel);
                    }
                });
            }
            else {
                printf("accept() failed;");
            }
        }
    });

    // Resume the source so we're ready to accept once we listen()
    dispatch_resume(acceptSource);

    // Listen() on the socket
    if (listen(servSock, SOMAXCONN) < 0) {
        shutdown(servSock, SHUT_RDWR);
        close(servSock);
        DieWithError("listen() failed");
    }

    // Make cleanup block for the server queue
    __block dispatch_block_t cleanupBlock = ^{
        dispatch_async(q, ^{
            shutdown(servSock, SHUT_RDWR);
            close(servSock);
//            dispatch_release(acceptSource);
//            dispatch_release(q);
        });
    };

    return cleanupBlock;
}

#endif /* dispatch_echo_h */

/**
 * WinPR: Windows Portable Runtime
 * Windows Sockets (Winsock)
 *
 * Copyright 2012 Marc-Andre Moreau <marcandre.moreau@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef WINPR_WINSOCK_H
#define WINPR_WINSOCK_H

#include <winpr/winpr.h>
#include <winpr/wtypes.h>
#include <winpr/windows.h>

#ifdef _WIN32

#if (_WIN32_WINNT < 0x0600)

PCSTR inet_ntop(INT Family, PVOID pAddr, PSTR pStringBuf, size_t StringBufSize);

#endif /* (_WIN32_WINNT < 0x0600) */

#else /* _WIN32 */

#include <sys/socket.h>

typedef struct sockaddr_storage SOCKADDR_STORAGE;

#endif /* _WIN32 */

#endif /* WINPR_WINSOCK_H */


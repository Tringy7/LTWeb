<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!-- Messenger Full Screen Layout -->
        <div id="messengerContainer" class="messenger-container">
            <!-- Left Sidebar - Contact List -->
            <div class="messenger-sidebar">
                <!-- Sidebar Header -->
                <div class="sidebar-header">
                    <h4 class="mb-0">Đoạn chat</h4>
                </div>

                <!-- Search Box -->
                <div class="sidebar-search">
                    <div class="search-wrapper">
                        <i class="fa fa-search"></i>
                        <input type="text" placeholder="Tìm kiếm người dùng" id="searchInput">
                    </div>
                </div>

                <!-- Contact List -->
                <div class="contact-list" id="contactList">
                    <c:choose>
                        <c:when test="${not empty users}">
                            <c:forEach var="user" items="${users}">
                                <div class="contact-item"
                                    onclick="selectContact(this, '${user.email}', '${user.shop.shopName}')">
                                    <div class="contact-avatar">
                                        <img src="/admin/images/user/${user.image}" alt="Avatar">

                                        <span class="status-dot"></span>
                                    </div>
                                    <div class="contact-info">
                                        <h6 class="contact-name">${user.shop.shopName}</h6>
                                        <p class="contact-message">Nhấn để bắt đầu trò chuyện</p>
                                    </div>
                                    <div class="contact-time"></div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="fa fa-comments" style="font-size: 48px; color: #bcc0c4;"></i>
                                <p class="text-muted mt-3">Chưa có cuộc trò chuyện nào</p>
                                <small class="text-muted">Bắt đầu nhắn tin với người bán từ trang sản phẩm</small>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Right Side - Chat Area -->
            <div class="messenger-chat-area">
                <!-- Chat Header -->
                <div class="chat-header" id="chatHeader" style="display: none;">
                    <div class="d-flex align-items-center">
                        <div class="chat-avatar">
                            <img src="/admin/images/user/user1.jpg" alt="Avatar" id="chatAvatar">
                            <span class="status-dot online"></span>
                        </div>
                        <div class="chat-user-info">
                            <h5 class="mb-0" id="chatUserName"></h5>
                            <small class="text-muted" id="chatUserStatus">Đang hoạt động</small>
                        </div>
                    </div>
                </div>

                <!-- Messages Area -->
                <div class="chat-messages" id="chatMessages">
                    <div class="text-center py-5" id="welcomeScreen">
                        <div class="welcome-icon mx-auto mb-3">
                            <i class="fa fa-comments" style="font-size: 80px; color: #0084ff;"></i>
                        </div>
                        <p class="text-muted">Chọn một cuộc trò chuyện bên trái để bắt đầu nhắn tin</p>
                    </div>
                </div>

                <!-- Message Input -->
                <div class="chat-input-area" id="chatInputArea" style="display: none;">
                    <div class="input-wrapper">
                        <input type="text" class="chat-input" id="messageInput" placeholder="Aa"
                            onkeypress="handleKeyPress(event)">
                        <button class="send-btn" onclick="sendMessage()" id="sendBtn">
                            <i class="fa fa-paper-plane"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <style>
            /* Main Messenger Container */
            .messenger-container {
                width: 100%;
                min-height: calc(100vh - 200px);
                background: white;
                display: flex;
                margin-top: 20px;
                margin-bottom: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            /* Left Sidebar - Contact List */
            .messenger-sidebar {
                width: 360px;
                min-height: 600px;
                border-right: 1px solid #e4e6eb;
                display: flex;
                flex-direction: column;
                background: white;
            }

            .sidebar-header {
                padding: 16px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #e4e6eb;
            }

            .sidebar-header h4 {
                font-size: 24px;
                font-weight: 700;
                color: #050505;
            }

            .icon-btn {
                background: #e4e6eb;
                border: none;
                width: 36px;
                height: 36px;
                border-radius: 50%;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #050505;
                transition: background 0.2s;
            }

            .icon-btn:hover {
                background: #d8dadf;
            }

            /* Search Box */
            .sidebar-search {
                padding: 12px 16px;
            }

            .search-wrapper {
                background: #f0f2f5;
                border-radius: 20px;
                padding: 8px 12px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .search-wrapper i {
                color: #65676b;
                font-size: 14px;
            }

            .search-wrapper input {
                border: none;
                background: transparent;
                outline: none;
                flex: 1;
                font-size: 15px;
                color: #050505;
            }

            .search-wrapper input::placeholder {
                color: #65676b;
            }

            /* Contact List */
            .contact-list {
                flex: 1;
                overflow-y: auto;
                padding: 8px 0;
            }

            .contact-list::-webkit-scrollbar {
                width: 8px;
            }

            .contact-list::-webkit-scrollbar-track {
                background: transparent;
            }

            .contact-list::-webkit-scrollbar-thumb {
                background: #bcc0c4;
                border-radius: 4px;
            }

            .contact-item {
                padding: 8px 16px;
                display: flex;
                align-items: center;
                gap: 12px;
                cursor: pointer;
                transition: background 0.2s;
                position: relative;
            }

            .contact-item:hover {
                background: #f2f3f5;
            }

            .contact-item.active {
                background: #e7f3ff;
            }

            .contact-avatar {
                position: relative;
                width: 56px;
                height: 56px;
                flex-shrink: 0;
            }

            .contact-avatar img {
                width: 100%;
                height: 100%;
                border-radius: 50%;
                object-fit: cover;
            }

            .status-dot {
                position: absolute;
                bottom: 2px;
                right: 2px;
                width: 14px;
                height: 14px;
                background: #b0b3b8;
                border: 3px solid white;
                border-radius: 50%;
            }

            .status-dot.online {
                background: #31a24c;
            }

            .contact-info {
                flex: 1;
                min-width: 0;
            }

            .contact-name {
                font-size: 15px;
                font-weight: 500;
                color: #050505;
                margin: 0;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .contact-message {
                font-size: 13px;
                color: #65676b;
                margin: 2px 0 0 0;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .contact-time {
                font-size: 12px;
                color: #65676b;
                align-self: flex-start;
                margin-top: 8px;
            }

            /* Right Side - Chat Area */
            .messenger-chat-area {
                flex: 1;
                display: flex;
                flex-direction: column;
                background: white;
            }

            /* Chat Header */
            .chat-header {
                padding: 12px 20px;
                border-bottom: 1px solid #e4e6eb;
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: white;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            }

            .chat-avatar {
                position: relative;
                width: 40px;
                height: 40px;
                margin-right: 12px;
            }

            .chat-avatar img {
                width: 100%;
                height: 100%;
                border-radius: 50%;
                object-fit: cover;
            }

            .chat-user-info h5 {
                font-size: 16px;
                font-weight: 600;
                color: #050505;
            }

            .chat-user-info small {
                font-size: 12px;
                color: #65676b;
            }

            /* Messages Area */
            .chat-messages {
                flex: 1;
                overflow-y: auto;
                padding: 20px;
                background: white;
                display: flex;
                flex-direction: column;
            }

            .chat-messages::-webkit-scrollbar {
                width: 8px;
            }

            .chat-messages::-webkit-scrollbar-track {
                background: transparent;
            }

            .chat-messages::-webkit-scrollbar-thumb {
                background: #bcc0c4;
                border-radius: 4px;
            }

            .welcome-avatar {
                width: 80px;
                height: 80px;
            }

            .welcome-avatar img {
                width: 100%;
                height: 100%;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #f0f2f5;
            }

            /* Message Bubbles */
            .message-group {
                margin-bottom: 12px;
                display: flex;
                align-items: flex-end;
                gap: 8px;
            }

            .message-group.sent {
                flex-direction: row-reverse;
            }

            .message-avatar {
                width: 28px;
                height: 28px;
                flex-shrink: 0;
            }

            .message-avatar img {
                width: 100%;
                height: 100%;
                border-radius: 50%;
                object-fit: cover;
            }

            .message-content {
                max-width: 60%;
                display: flex;
                flex-direction: column;
            }

            .message-group.sent .message-content {
                align-items: flex-end;
            }

            .message-bubble {
                background: #e4e6eb;
                color: #050505;
                padding: 8px 12px;
                border-radius: 18px;
                margin-bottom: 2px;
                word-wrap: break-word;
                animation: messageSlideIn 0.2s ease-out;
            }

            .message-group.sent .message-bubble {
                background: #0084ff;
                color: white;
            }

            @keyframes messageSlideIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .message-time {
                font-size: 11px;
                color: #65676b;
                margin-top: 4px;
                padding: 0 4px;
            }

            /* Message Input Area */
            .chat-input-area {
                padding: 12px 20px;
                border-top: 1px solid #e4e6eb;
                background: white;
            }

            .input-wrapper {
                display: flex;
                align-items: center;
                background: #f0f2f5;
                border-radius: 20px;
                padding: 4px 8px;
                gap: 4px;
            }

            .input-icon-btn {
                background: transparent;
                border: none;
                color: #0084ff;
                width: 32px;
                height: 32px;
                border-radius: 50%;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background 0.2s;
                font-size: 18px;
            }

            .input-icon-btn:hover {
                background: #e4e6eb;
            }

            .chat-input {
                flex: 1;
                border: none;
                background: transparent;
                padding: 8px 12px;
                font-size: 15px;
                outline: none;
                color: #050505;
            }

            .chat-input::placeholder {
                color: #8a8d91;
            }

            .send-btn {
                background: #0084ff;
                border: none;
                color: white;
                width: 32px;
                height: 32px;
                border-radius: 50%;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s;
                font-size: 14px;
            }

            .send-btn:hover {
                background: #006dcc;
                transform: scale(1.05);
            }

            .send-btn:active {
                transform: scale(0.95);
            }

            /* Mobile Responsive */
            @media (max-width: 768px) {
                .messenger-sidebar {
                    width: 100%;
                    position: absolute;
                    z-index: 10;
                    transition: transform 0.3s;
                }

                .messenger-sidebar.hidden {
                    transform: translateX(-100%);
                }

                .messenger-chat-area {
                    width: 100%;
                }
            }

            /* Typing Indicator */
            .typing-indicator {
                display: flex;
                align-items: center;
                gap: 4px;
                padding: 12px;
                background: #e4e6eb;
                border-radius: 18px;
                width: fit-content;
            }

            .typing-dot {
                width: 8px;
                height: 8px;
                background: #65676b;
                border-radius: 50%;
                animation: typingBounce 1.4s infinite;
            }

            .typing-dot:nth-child(2) {
                animation-delay: 0.2s;
            }

            .typing-dot:nth-child(3) {
                animation-delay: 0.4s;
            }

            @keyframes typingBounce {

                0%,
                60%,
                100% {
                    transform: translateY(0);
                }

                30% {
                    transform: translateY(-8px);
                }
            }
        </style>

        <script>
            let chatMessages = [];
            const currentUserId = '${pageContext.request.userPrincipal.name}';
            let activeShopOwnerId = null;
            let websocket = null;

            // Initialize WebSocket
            function initWebSocket() {
                if (!currentUserId) return;

                const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
                const wsUrl = protocol + '//' + window.location.host + '/chat?user=' + encodeURIComponent(currentUserId);

                websocket = new WebSocket(wsUrl);

                websocket.onopen = function (event) {
                    console.log('Messenger connected');
                };

                websocket.onmessage = function (event) {
                    try {
                        const messageData = JSON.parse(event.data);

                        // Only show message if it's part of the active conversation
                        const isRelevant = activeShopOwnerId &&
                            (messageData.sender.email === activeShopOwnerId || messageData.receiver.email === activeShopOwnerId);

                        if (isRelevant) {
                            const messagesContainer = document.getElementById('chatMessages');
                            const avatarSrc = document.getElementById('chatAvatar').src;

                            // Remove welcome message if exists
                            const welcomeMsg = messagesContainer.querySelector('#welcomeScreen');
                            if (welcomeMsg) {
                                messagesContainer.innerHTML = '';
                            }

                            messagesContainer.insertAdjacentHTML('beforeend', createMessageHTMLFromDTO(messageData, avatarSrc));
                            scrollToBottom();
                        }
                    } catch (error) {
                        console.error('❌ Error parsing message:', error);
                    }
                };

                websocket.onerror = function (error) {
                    console.error('❌ WebSocket error:', error);
                };

                websocket.onclose = function (event) {
                    console.log('🔌 WebSocket disconnected');
                    setTimeout(initWebSocket, 3000);
                };
            }

            if (currentUserId) {
                initWebSocket();
            }

            // Select contact from sidebar
            function selectContact(element, shopOwnerId, shopName) {
                // Update active state
                document.querySelectorAll('.contact-item').forEach(item => {
                    item.classList.remove('active');
                });
                element.classList.add('active');

                // Update active shop owner
                activeShopOwnerId = shopOwnerId;

                // Show chat header and input area
                document.getElementById('chatHeader').style.display = 'flex';
                document.getElementById('chatInputArea').style.display = 'block';

                // Update chat header with shop name
                document.getElementById('chatUserName').textContent = shopName;

                // Get avatar from contact item
                const avatarImg = element.querySelector('.contact-avatar img');
                if (avatarImg) {
                    document.getElementById('chatAvatar').src = avatarImg.src;
                }

                // Load chat history for this contact
                loadChatHistory();
            }

            async function loadChatHistory(silent = false) {
                if (!activeShopOwnerId) return;

                const messagesContainer = document.getElementById('chatMessages');

                try {
                    const response = await fetch(`/api/messages/${currentUserId}/${activeShopOwnerId}`);

                    if (response.ok) {
                        const messages = await response.json();
                        const chatAvatarSrc = document.getElementById('chatAvatar').src;
                        const chatUserName = document.getElementById('chatUserName').textContent;

                        if (messages.length === 0) {
                            messagesContainer.innerHTML = `
                                <div class="text-center py-5" id="welcomeScreen">
                                    <div class="welcome-avatar mx-auto mb-3">
                                        <img src="${chatAvatarSrc}" alt="Avatar">
                                    </div>
                                    <h5>${chatUserName}</h5>
                                    <p class="text-muted">Bạn và ${chatUserName} đã kết nối trên Messenger</p>
                                    <small class="text-muted">Bắt đầu cuộc trò chuyện ngay!</small>
                                </div>
                            `;
                        } else {
                            let html = '';
                            messages.forEach(msgDTO => {
                                html += createMessageHTMLFromDTO(msgDTO, chatAvatarSrc);
                            });
                            messagesContainer.innerHTML = html;
                            scrollToBottom(true); // Scroll instantly on load
                        }
                    } else {
                        const error = await response.json();
                        messagesContainer.innerHTML = `<div class="text-center py-5 text-danger">Lỗi tải tin nhắn: ${error.error}</div>`;
                        console.error('Error response:', error);
                    }
                } catch (error) {
                    console.error('Error loading chat:', error);
                }
            }

            function formatTime(timestamp) {
                const date = new Date(timestamp);
                const hours = date.getHours().toString().padStart(2, '0');
                const minutes = date.getMinutes().toString().padStart(2, '0');
                return hours + ':' + minutes;
            }

            function createMessageHTMLFromDTO(messageDTO, avatarSrc) {
                const isSent = messageDTO.sender.email === currentUserId;
                const messageClass = isSent ? 'sent' : 'received';

                // Escape HTML to prevent XSS
                const escapedText = (messageDTO.content || '')
                    .replace(/&/g, '&amp;')
                    .replace(/</g, '&lt;')
                    .replace(/>/g, '&gt;')
                    .replace(/"/g, '&quot;')
                    .replace(/'/g, '&#039;');

                const avatarHTML = !isSent ? `<div class="message-avatar"><img src="${avatarSrc}" alt="Avatar"></div>` : '';

                return `
                    <div class="message-group ${messageClass}" data-message-id="${messageDTO.id}">
                        ${avatarHTML}
                        <div class="message-content">
                            <div class="message-bubble">
                                ${escapedText}
                            </div>
                            <div class="message-time">${message.time}</div>
                            <div class="message-time">${messageDTO.timestamp}</div>
                        </div>
                    </div>
                `;
            }

            async function sendMessage() {
                if (!activeShopOwnerId) {
                    alert('Vui lòng chọn một người để nhắn tin!');
                    return;
                }

                const input = document.getElementById('messageInput');
                const messageText = input.value.trim();

                if (messageText === '') return;

                if (!websocket || websocket.readyState !== WebSocket.OPEN) {
                    alert('Kết nối đang được thiết lập. Vui lòng thử lại!');
                    return;
                }

                try {
                    const message = {
                        sender: currentUserId,
                        receiver: activeShopOwnerId,
                        content: messageText
                    };

                    websocket.send(JSON.stringify(message));
                    input.value = '';

                    // Add animation to send button
                    const sendBtn = document.getElementById('sendBtn');
                    sendBtn.style.transform = 'scale(0.9)';
                    setTimeout(() => {
                        sendBtn.style.transform = 'scale(1)';
                    }, 200);

                } catch (error) {
                    console.error('Error sending message:', error);
                    alert('Có lỗi xảy ra khi gửi tin nhắn!');
                }
            }

            function handleKeyPress(event) {
                if (event.key === 'Enter' && !event.shiftKey) {
                    event.preventDefault();
                    sendMessage();
                }
            }

            function scrollToBottom(instant = false) {
                const messagesContainer = document.getElementById('chatMessages');
                messagesContainer.scrollTo({
                    top: messagesContainer.scrollHeight,
                    behavior: instant ? 'auto' : 'smooth'
                });
            }

            // Search functionality
            document.addEventListener('DOMContentLoaded', function () {
                const searchInput = document.getElementById('searchInput');
                if (searchInput) {
                    searchInput.addEventListener('input', function (e) {
                        const searchTerm = e.target.value.toLowerCase();
                        const contacts = document.querySelectorAll('.contact-item');

                        contacts.forEach(contact => {
                            const name = contact.querySelector('.contact-name').textContent.toLowerCase();
                            const message = contact.querySelector('.contact-message').textContent.toLowerCase();

                            if (name.includes(searchTerm) || message.includes(searchTerm)) {
                                contact.style.display = 'flex';
                            } else {
                                contact.style.display = 'none';
                            }
                        });
                    });
                }
            });
        </script>
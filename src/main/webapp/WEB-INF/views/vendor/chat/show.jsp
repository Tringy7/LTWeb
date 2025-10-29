<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!-- WebSocket Libraries -->
        <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


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
                                <c:choose>
                                    <c:when test="${not empty user.shop}">
                                        <div class="contact-item" data-shop-id="${user.shop.id}"
                                            data-user-id="${user.id}" data-fullname="${user.fullName}"
                                            data-image="${user.image}" onclick="selectContact(this)">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="contact-item" data-shop-id="" data-user-id="${user.id}"
                                            data-fullname="${user.fullName}" data-image="${user.image}"
                                            onclick="selectContact(this)">
                                    </c:otherwise>
                                </c:choose>
                                <div class="contact-avatar">
                                    <img src="/admin/images/user/${user.image}" alt="Avatar">
                                </div>
                                <div class="contact-info">
                                    <h6 class="contact-name">${user.fullName}</h6>
                                    <p class="contact-message">Nhấn để bắt đầu trò chuyện</p>
                                </div>
                                <div class="contact-actions">
                                    <button class="delete-contact-btn"
                                        onclick="event.stopPropagation(); deleteContact(this.closest('.contact-item').dataset.userId, this.closest('.contact-item').dataset.shopId)"
                                        title="Xóa cuộc trò chuyện">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </div>
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
                    </div>
                    <div class="chat-user-info">
                        <h5 class="mb-0" id="chatUserName"></h5>
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

            .contact-actions {
                display: flex;
                align-items: center;
                gap: 4px;
                opacity: 0;
                transition: opacity 0.2s;
            }

            .contact-item:hover .contact-actions {
                opacity: 1;
            }

            .delete-contact-btn {
                background: transparent;
                border: none;
                color: #65676b;
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

            .delete-contact-btn:hover {
                background: #ffebe9;
                color: #e41e3f;
                transform: scale(1.1);
            }

            .delete-contact-btn:active {
                transform: scale(0.95);
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
                padding: 10.5px 20px;
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
                overflow-x: hidden;
                padding: 20px;
                background: white;
                display: flex;
                flex-direction: column;
                max-height: calc(100vh - 200px);
                min-height: 400px;
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
                align-items: flex-start;
                gap: 8px;
            }

            .message-group.sent {
                flex-direction: row-reverse;
            }

            .message-avatar {
                width: 28px;
                height: 28px;
                flex-shrink: 0;
                margin-top: 6px;
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
            const currentUserId = ${currentUser.id};
            const currentUserEmail = '${currentUser.email}';
            const isVendor = true;
            let activeShopOwnerId = null;
            let activeShopId = null;
            let stompClient = null;

            // Initialize WebSocket using SockJS and Stomp
            function initWebSocket() {
                if (!currentUserId) return;

                const socket = new SockJS('/chat');
                stompClient = Stomp.over(socket);

                stompClient.connect({}, function (frame) {
                    console.log('✅ WebSocket connected:', frame);

                    // Subscribe to personal message queue
                    stompClient.subscribe('/queue/messages/' + currentUserId, function (message) {
                        try {
                            const messageDTO = JSON.parse(message.body);
                            console.log('📩 Received message:', messageDTO);

                            // Check if message is relevant to current conversation
                            const isRelevant = activeShopOwnerId &&
                                (messageDTO.sender.id === activeShopOwnerId ||
                                    messageDTO.receiver.id === activeShopOwnerId);

                            if (isRelevant) {
                                displayMessage(messageDTO);
                            }

                            // Update last message in contact list
                            updateContactLastMessage(messageDTO);
                        } catch (error) {
                            console.error('❌ Error processing message:', error);
                        }
                    });

                    // Subscribe to error queue
                    stompClient.subscribe('/queue/errors/' + currentUserId, function (error) {
                        console.error('❌ Server error:', error.body);
                        alert('Lỗi: ' + error.body);
                    });
                }, function (error) {
                    console.error('❌ WebSocket connection error:', error);
                    setTimeout(initWebSocket, 3000); // Reconnect after 3s
                });
            }

            // Display a message in chat
            function displayMessage(messageDTO) {
                console.log('💬 Displaying message:', messageDTO);
                const messagesContainer = document.getElementById('chatMessages');

                // Remove welcome message if exists
                const welcomeMsg = messagesContainer.querySelector('#welcomeScreen');
                if (welcomeMsg) {
                    console.log('🗑️ Removing welcome screen');
                    messagesContainer.innerHTML = '';
                }

                const chatAvatarSrc = document.getElementById('chatAvatar').src;
                const messageHTML = createMessageHTMLFromDTO(messageDTO, chatAvatarSrc);
                console.log('📝 Generated HTML:', messageHTML.substring(0, 100) + '...');

                if (messageHTML) {
                    messagesContainer.insertAdjacentHTML('beforeend', messageHTML);
                    scrollToBottom();
                }
            }

            // Update last message in contact item
            function updateContactLastMessage(messageDTO) {
                // Find contact item by user id
                const contacts = document.querySelectorAll('.contact-item');
                contacts.forEach(contact => {
                    // You can add data attributes to identify contacts
                    const contactMessage = contact.querySelector('.contact-message');
                    if (contactMessage) {
                        // Update with last message preview
                        const preview = messageDTO.content.substring(0, 30) +
                            (messageDTO.content.length > 30 ? '...' : '');
                        contactMessage.textContent = preview || 'No content';
                    }
                });
            }

            // Initialize on page load
            if (currentUserId) {
                initWebSocket();
            }

            // Delete contact/conversation
            async function deleteContact(userId, shopId) {
                if (!confirm('Bạn có chắc chắn muốn xóa cuộc trò chuyện này?')) {
                    return;
                }

                try {
                    console.log('🗑️ Deleting conversation - userId:', userId, 'shopId:', shopId);

                    // Determine endpoint: if shopId exists, call shop-delete endpoint, otherwise user-delete
                    let endpoint = '';
                    if (shopId && shopId !== '' && shopId !== '0') {
                        endpoint = '/api/chat/delete/shop/' + shopId;
                    } else {
                        endpoint = '/api/chat/delete/user/' + userId;
                    }

                    // Call API to delete conversation
                    const response = await fetch(endpoint, {
                        method: 'DELETE',
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    });

                    if (response.ok) {
                        console.log('✅ Conversation deleted successfully');

                        // Remove contact from UI
                        const contactItem = document.querySelector(`.contact-item[data-shop-id="${shopId}"]`);
                        if (contactItem) {
                            contactItem.remove();
                        }

                        // If this was the active conversation, clear chat area
                        if (activeShopId === shopId) {
                            document.getElementById('chatHeader').style.display = 'none';
                            document.getElementById('chatInputArea').style.display = 'none';
                            document.getElementById('chatMessages').innerHTML = `
                                <div class="text-center py-5" id="welcomeScreen">
                                    <div class="welcome-icon mx-auto mb-3">
                                        <i class="fa fa-comments" style="font-size: 80px; color: #0084ff;"></i>
                                    </div>
                                    <p class="text-muted">Chọn một cuộc trò chuyện bên trái để bắt đầu nhắn tin</p>
                                </div>
                            `;
                            activeShopId = null;
                            activeShopOwnerId = null;
                        }

                        // Check if no contacts left
                        const remainingContacts = document.querySelectorAll('.contact-item').length;
                        if (remainingContacts === 0) {
                            document.getElementById('contactList').innerHTML = `
                                <div class="text-center py-5">
                                    <i class="fa fa-comments" style="font-size: 48px; color: #bcc0c4;"></i>
                                    <p class="text-muted mt-3">Chưa có cuộc trò chuyện nào</p>
                                    <small class="text-muted">Bắt đầu nhắn tin với người bán từ trang sản phẩm</small>
                                </div>
                            `;
                        }

                        // Show success message
                        alert('Đã xóa cuộc trò chuyện thành công!');
                    } else {
                        const errorText = await response.text();
                        console.error('❌ Error deleting conversation:', errorText);
                        alert('Lỗi khi xóa cuộc trò chuyện: ' + errorText);
                    }
                } catch (error) {
                    console.error('❌ Error deleting conversation:', error);
                    alert('Có lỗi xảy ra khi xóa cuộc trò chuyện!');
                }
            }

            // Select contact from sidebar
            function selectContact(element) {
                // Read values from data attributes
                const userId = element.dataset.userId;
                const shopId = element.dataset.shopId;
                const fullName = element.dataset.fullname;
                const userImage = element.dataset.image;
                // Update active state
                document.querySelectorAll('.contact-item').forEach(item => {
                    item.classList.remove('active');
                });
                element.classList.add('active');

                // Update active IDs
                activeShopOwnerId = Number(userId);
                // Normalize shopId
                if (!shopId || shopId === '' || shopId === '0') {
                    activeShopId = null;
                } else {
                    activeShopId = Number(shopId);
                }

                // Show chat header and input area
                document.getElementById('chatHeader').style.display = 'flex';
                document.getElementById('chatInputArea').style.display = 'block';

                // Update chat header with shop name
                document.getElementById('chatUserName').textContent = fullName;
                document.getElementById('chatAvatar').src = '/admin/images/user/' + userImage;

                // Load chat history for this contact
                loadChatHistory();
            }

            async function loadChatHistory(silent = false) {
                const messagesContainer = document.getElementById('chatMessages');

                if (!activeShopOwnerId) return;

                try {
                    // If activeShopId exists, use shop-based endpoint (client-style)
                    if (activeShopId) {
                        console.log('🔍 Loading chat history for shopId:', activeShopId);
                        const response = await fetch('/api/chat/history/' + activeShopId);
                        console.log('📡 Response status:', response.status);

                        if (response.ok) {
                            const messages = await response.json();
                            console.log('📨 Received messages:', messages);
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
                                    const msgHtml = createMessageHTMLFromDTO(msgDTO, chatAvatarSrc);
                                    if (msgHtml) {
                                        html += msgHtml;
                                    }
                                });
                                messagesContainer.innerHTML = html;
                                scrollToBottom(true); // Scroll instantly on load
                            }
                        } else {
                            const errorText = await response.text();
                            console.error('❌ Error response:', errorText);
                            messagesContainer.innerHTML = `<div class="text-center py-5 text-danger">Lỗi tải tin nhắn</div>`;
                        }

                        return;
                    }

                    // Vendor path: load by user id
                    console.log('🔍 Loading chat history for userId:', activeShopOwnerId);
                    const response = await fetch('/api/chat/history/user/' + activeShopOwnerId);
                    console.log('📡 Response status:', response.status);

                    if (response.ok) {
                        const messages = await response.json();
                        console.log('📨 Received messages:', messages);
                        const chatAvatarSrc = document.getElementById('chatAvatar').src;
                        const chatUserName = document.getElementById('chatUserName').textContent;

                        if (messages.length === 0) {
                            messagesContainer.innerHTML = `
                        <div class="text-center py-5" id="welcomeScreen">
                            <div class="welcome-avatar mx-auto mb-3">
                                <img src="${chatAvatarSrc}" alt="Avatar">
                            </div>
                            <h5>${chatUserName}</h5>
                            <p class="text-muted">Chưa có tin nhắn với người dùng này.</p>
                        </div>
                    `;
                        } else {
                            let html = '';
                            messages.forEach(msgDTO => {
                                const msgHtml = createMessageHTMLFromDTO(msgDTO, chatAvatarSrc);
                                if (msgHtml) {
                                    html += msgHtml;
                                }
                            });
                            messagesContainer.innerHTML = html;
                            scrollToBottom(true);
                        }
                    } else {
                        const errorText = await response.text();
                        console.error('❌ Error response:', errorText);
                        messagesContainer.innerHTML = `<div class="text-center py-5 text-danger">Lỗi tải tin nhắn</div>`;
                    }
                } catch (error) {
                    console.error('❌ Error loading chat:', error);
                    messagesContainer.innerHTML = `<div class="text-center py-5 text-danger">Lỗi kết nối: ${error.message}</div>`;
                }
            }

            function formatTime(timestamp) {
                const date = new Date(timestamp);
                const hours = date.getHours().toString().padStart(2, '0');
                const minutes = date.getMinutes().toString().padStart(2, '0');
                return hours + ':' + minutes;
            }

            function createMessageHTMLFromDTO(messageDTO, avatarSrc) {
                const isSent = messageDTO.sender.id === currentUserId;
                const messageClass = isSent ? 'sent' : 'received';

                // Check if content exists first
                const content = messageDTO.content || '';
                if (!content.trim()) {
                    console.warn('⚠️ Skipping empty content message:', messageDTO);
                    return '';
                }

                // Escape HTML to prevent XSS
                const escapedText = content
                    .replace(/&/g, '&amp;')
                    .replace(/</g, '&lt;')
                    .replace(/>/g, '&gt;')
                    .replace(/"/g, '&quot;')
                    .replace(/'/g, '&#039;');

                const avatarHTML = !isSent ? '<div class="message-avatar"><img src="' + avatarSrc + '" alt="Avatar"></div>' : '';
                const formattedTime = formatTime(messageDTO.timestamp);

                return '<div class="message-group ' + messageClass + '" data-message-id="' + messageDTO.id + '">' +
                    avatarHTML +
                    '<div class="message-content">' +
                    '<div class="message-bubble">' +
                    escapedText +
                    '</div>' +
                    '<div class="message-time">' + formattedTime + '</div>' +
                    '</div>' +
                    '</div>';
            }

            async function sendMessage() {
                if (!activeShopOwnerId) {
                    alert('Vui lòng chọn một người để nhắn tin!');
                    return;
                }

                const input = document.getElementById('messageInput');
                const messageText = input.value.trim();

                if (messageText === '') return;

                if (!stompClient || !stompClient.connected) {
                    alert('Kết nối đang được thiết lập. Vui lòng thử lại!');
                    return;
                }

                try {
                    const messageDTO = {
                        sender: {
                            id: Number(currentUserId),
                            email: currentUserEmail,
                            fullName: '${currentUser.fullName}',
                            avatar: '${currentUser.image}'
                        },
                        receiver: {
                            id: activeShopOwnerId
                        },
                        content: messageText,
                        timestamp: new Date().toISOString()
                    };
                    console.log('📤 Sending message:', messageDTO);

                    if (isVendor) {
                        console.log('📍 Destination (vendor): /app/vendor/chat/send/' + activeShopOwnerId);
                        // Send to user via vendor endpoint
                        stompClient.send(
                            '/app/vendor/chat/send/' + activeShopOwnerId,
                            {},
                            JSON.stringify(messageDTO)
                        );
                    } else {
                        console.log('📍 Destination: /app/chat/send/' + activeShopId);
                        // Send to shop owner via /app/chat/send/{shopId}
                        stompClient.send(
                            '/app/chat/send/' + activeShopId,
                            {},
                            JSON.stringify(messageDTO)
                        );
                    }

                    console.log('✅ Message sent successfully');
                    input.value = '';

                    // Add animation to send button
                    const sendBtn = document.getElementById('sendBtn');
                    sendBtn.style.transform = 'scale(0.9)';
                    setTimeout(() => {
                        sendBtn.style.transform = 'scale(1)';
                    }, 200);

                } catch (error) {
                    console.error('❌ Error sending message:', error);
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

                // Auto-select shop if shopId is in URL parameter
                const urlParams = new URLSearchParams(window.location.search);
                const shopIdParam = urlParams.get('shopId');

                if (shopIdParam) {
                    console.log('🎯 Auto-selecting shop with ID:', shopIdParam);

                    // Find the contact item with matching shop ID using data attribute
                    const targetContact = document.querySelector(`.contact-item[data-shop-id="${shopIdParam}"]`);

                    if (targetContact) {
                        console.log('✅ Found matching shop contact, auto-clicking...');
                        // Trigger click on this contact after a small delay
                        setTimeout(() => {
                            targetContact.click();
                            // Remove shopId from URL to prevent auto-click on refresh
                            const newUrl = window.location.pathname;
                            window.history.replaceState({}, '', newUrl);
                        }, 500);
                    } else {
                        console.warn('⚠️ No contact found for shop ID:', shopIdParam);
                        console.log('Available contacts:', document.querySelectorAll('.contact-item').length);
                    }
                }
            });
        </script>
<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
    <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
        <a class="navbar-brand brand-logo" href="/shipper"><span
                class="text-primary font-weight-bold">SHIPPER</span></a>
    </div>
    <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">

        <ul class="navbar-nav navbar-nav-right">

            <li class="nav-item nav-profile dropdown">
                <a class="nav-link dropdown-toggle pl-0 pr-0" href="#" id="profileDropdown"
                    onclick="toggleDropdown(event)">
                    <i class="typcn typcn-user-outline mr-0"></i>
                    <span class="nav-profile-name">${acc.email}</span>
                </a>
                <div class="dropdown-menu dropdown-menu-right navbar-dropdown" id="profileDropdownMenu"
                    aria-labelledby="profileDropdown">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                        <i class="typcn typcn-power text-primary mr-2"></i>
                        Logout
                    </a>
                </div>
            </li>
        </ul>
        <script>
            function toggleDropdown(event) {
                event.preventDefault();
                event.stopPropagation();
                const menu = document.getElementById('profileDropdownMenu');
                menu.classList.toggle('show');
            }

            // Close dropdown when clicking outside
            document.addEventListener('click', function (event) {
                const dropdown = document.getElementById('profileDropdownMenu');
                const trigger = document.getElementById('profileDropdown');
                if (dropdown && !trigger.contains(event.target)) {
                    dropdown.classList.remove('show');
                }
            });
        </script>
        <!-- <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button"
            data-toggle="offcanvas">
            <span class="typcn typcn-th-menu"></span>
        </button> -->
    </div>
</nav>
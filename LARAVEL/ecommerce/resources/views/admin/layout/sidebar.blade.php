<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="./">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-store"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Ecommerce</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item">
        <a class="nav-link" href="./">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span></a>
    </li>

    <!-- Nav Item - Visit Site -->
    <li class="nav-item">
        <a class="nav-link" href="../" add target="_blank">
            <i class="fas fa-fw fa-globe"></i>
            <span>Visit Site</span></a>
    </li>

    <!-- Manage User -->
    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Manage User
    </div>

    <!-- Nav Item - Pages Collapse Menu - Categories -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUsers"
            aria-expanded="true" aria-controls="collapseUsers">
            <i class="fas fa-users"></i>
            <span>Users</span>
        </a>
        <div id="collapseUsers" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <!-- <h6 class="collapse-header">Manage</h6> -->
                <a class="collapse-item" href="users.php">All Users</a>
                <a class="collapse-item" href="add_users.php">Add New</a>
            </div>
        </div>
    </li>

    <!-- End of Manage User -->

    <!-- Manage Shop -->

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Manage Shop
    </div>

    <!-- Nav Item - Pages Collapse Menu - Categories -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseCategories"
            aria-expanded="true" aria-controls="collapseCategories">
            <i class="fas fa-list-alt"></i>
            <span>Categories</span>
        </a>
        <div id="collapseCategories" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <!-- <h6 class="collapse-header">Manage</h6> -->
                <a class="collapse-item" href="categories.php">All Category</a>
                <a class="collapse-item" href="add_category.php">Add New</a>
            </div>
        </div>
    </li>

    <!-- Nav Item - Pages Collapse Menu - Products -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseProducts"
            aria-expanded="true" aria-controls="collapseProducts">
            <i class="fas fa-store-alt"></i>
            <span>Products</span>
        </a>
        <div id="collapseProducts" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <!-- <h6 class="collapse-header">Manage</h6> -->
                <a class="collapse-item" href="products.php">All Product</a>
                <a class="collapse-item" href="add_products.php">Add New</a>
            </div>
        </div>
    </li>

    <!-- Nav Item - Pages Collapse Menu - Orders -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseOrders"
            aria-expanded="true" aria-controls="collapseOrders">
            <i class="fab fa-first-order"></i>
            <span>Orders</span>
        </a>
        <div id="collapseOrders" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <!-- <h6 class="collapse-header">Manage</h6> -->
                <a class="collapse-item" href="orders.php">View All</a>
                <a class="collapse-item" href="#">Pending</a>
                <a class="collapse-item" href="#">Processing</a>
                <a class="collapse-item" href="#">Completed</a>
            </div>
        </div>
    </li>

    <!-- End of Manage Shop -->

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

    </ul>
<!-- End of Sidebar -->
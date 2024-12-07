document.addEventListener("DOMContentLoaded", () => {
    const sidebarLinks = document.querySelectorAll(".sidebar ul li a");
    const contentSections = document.querySelectorAll(".content-section");

    sidebarLinks.forEach(link => {
        link.addEventListener("click", e => {
            e.preventDefault();

            // Remove "active" class from all links
            sidebarLinks.forEach(link => link.classList.remove("active"));

            // Hide all content sections
            contentSections.forEach(section => section.classList.add("hidden"));

            // Activate clicked link and show corresponding section
            link.classList.add("active");
            const targetId = link.getAttribute("href").substring(1); // Remove '#' from href
            document.getElementById(targetId).classList.remove("hidden");
        });
    });
});

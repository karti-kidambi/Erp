// Example: Sidebar link highlighting
const links = document.querySelectorAll('.sidebar ul li a');
links.forEach(link => {
    link.addEventListener('click', () => {
        links.forEach(l => l.classList.remove('active'));
        link.classList.add('active');
    });
});
document.addEventListener("DOMContentLoaded", () => {
    const sidebarLinks = document.querySelectorAll(".sidebar ul li a");
    const sections = document.querySelectorAll(".content > div");

    sidebarLinks.forEach(link => {
        link.addEventListener("click", e => {
            e.preventDefault();
            sidebarLinks.forEach(l => l.classList.remove("active"));
            link.classList.add("active");

            sections.forEach(section => section.classList.add("hidden"));
            const targetSection = document.querySelector(link.getAttribute("href"));
            targetSection.classList.remove("hidden");
        });
    });
});

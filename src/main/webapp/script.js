document.getElementById("loginForm").addEventListener("submit", function(event) {
    const username = document.getElementById("username").value.trim();
    const password = document.getElementById("password").value.trim();
    const role = document.getElementById("role").value;

    if (!username || !password || !role) {
        alert("Please fill out all fields!");
        event.preventDefault(); // Prevent form submission
    }
});

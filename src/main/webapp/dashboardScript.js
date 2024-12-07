document.addEventListener('DOMContentLoaded', () => {
    const cards = document.querySelectorAll('.card');

    cards.forEach(card => {
        card.addEventListener('click', () => {
            const href = card.querySelector('a').getAttribute('href');

            // Check if the card ID is "attendance"
            if (card.id === 'attendance') {
                // Redirect to attendance.jsp
                window.location.href = "/attendance";
            } else {
                // Redirect to the specified URL from the href attribute
                window.location.href = href;
            }
        });
    });
});
const API_KEY = "07cc1400a985df5c89cf0bb83f752c6c";
const CITY = "Ho Chi Minh City";
const CACHE_KEY = "weather_hcm";
const CACHE_TIME = 30 * 60 * 1000; // 30 minutes

document.addEventListener("DOMContentLoaded", () => {
    loadWeather();
});

async function loadWeather() {
    try {
        const cached = localStorage.getItem(CACHE_KEY);
        if (cached) {
            const data = JSON.parse(cached);
            if (Date.now() - data.timestamp < CACHE_TIME) {
                renderWeather(data.weather);
                return;
            }
        }

        const res = await fetch(
            `https://api.openweathermap.org/data/2.5/weather?q=${CITY}&units=metric&appid=${API_KEY}`
        );

        if (!res.ok) throw new Error("Weather API error");

        const json = await res.json();

        const weather = {
            temp: Math.round(json.main.temp),
            main: json.weather[0].main
        };

        localStorage.setItem(
            CACHE_KEY,
            JSON.stringify({
                timestamp: Date.now(),
                weather
            })
        );

        renderWeather(weather);

    } catch (err) {
        console.error(err);
        document.getElementById("weatherText").innerText = "Weather unavailable";
    }
}

function renderWeather(weather) {
    const icon = getWeatherIcon(weather.main);
    document.getElementById("weatherIcon").innerText = icon;
    document.getElementById("weatherText").innerText =
        `${weather.temp}°C • ${weather.main}`;
}

function getWeatherIcon(type) {
    switch (type) {
        case "Clear": return "☀️";
        case "Clouds": return "☁️";
        case "Rain": return "🌧️";
        case "Snow": return "❄️";
        default: return "⛅";
    }
}
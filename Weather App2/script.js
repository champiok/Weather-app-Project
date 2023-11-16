const container = document.querySelector('.container');
const search = document.querySelector('.search-box button');
const weatherBox = document.querySelector('.weather-box');
const weatherDetails = document.querySelector('.weather-details');

search.addEventListener('click', () => {

    const API_KEY = '0446c8b545c32f565c6d377cadec1432';
    const city = document.querySelector('.search-box input').value;

    if (city == '')
        return;

    fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${API_KEY}`).then(response => response.json()).then(json => {
        
        const image = document.querySelector('.weather-box img');
        const temperature = document.querySelector('.weather-box .temperature');
        const description = document.querySelector('.weather-box .description');
        const humidity = document.querySelector('.weather-details .humidity span');
        const wind = document.querySelector('.weather-details .wind span');

        switch (json.weather[0].main) {
            case 'Clear':
                image.src = 'Weather/Sunny.png';
                break;

            case 'Rain':
                image.src = 'Weather/Rain.png';
                break;

            case 'Snow':
                image.src = 'Weather/Snow.png';
                break;

            case 'Cloud':
                image.src = 'Weather/Cloud.png';
                break;

            case 'Mist':
                image.src = 'Weather/Mist.png';
                break;

            case 'Haze':
                image.src = 'Weather/Mist.png';

            default:
                image.src = 'Weather/Cloud.png';
        }

        // Assuming json.main.temp contains the temperature in Celsius
        const celsiusTemperature = parseFloat(json.main.temp);
        const fahrenheitTemperature = (celsiusTemperature * 9/5) + 32;

        temperature.innerHTML = `${parseInt(fahrenheitTemperature)}<span>°F</span>`;

        //temperature.innerHTML = `${parseInt(json.main.temp)}<span>°F</span>`;
        description.innerHTML = `${json.weather[0].description}`;
        humidity.innerHTML = `${json.main.humidity}%`;
        wind.innerHTML = `${parseInt(json.wind.speed)}Km/h`;

    });

});
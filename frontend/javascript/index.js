import "$styles/index.css"
import "$styles/home.css";

import images from '../images/**/*.{jpg,jpeg,png,svg}'
Object.entries(images).forEach(image => image)

// Import all JavaScript & CSS files from src/_components
import components from "$components/**/*.{js,jsx,js.rb,css}"

console.info("Bridgetown is loaded!")

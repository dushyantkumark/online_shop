import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  base: './',
  css: {
    devSourcemap: false
  },
  server: {
    allowedHosts: ['my.awscloudshop.online']
  }
})

/*
import {defineConfig} from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [react()],
    base: './',
    css: {
      devSourcemap: false
    }
})
*/

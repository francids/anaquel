import { defineConfig } from 'vitepress';

export default defineConfig({
  title: 'Anaquel',
  description: 'Anaquel',
  themeConfig: {
    logo: '/icon.svg',
    siteTitle: false,
    nav: [
      { text: 'Intelligence', link: 'ai' }
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/francids/anaquel' }
    ]
  },
  locales: {
    root: {
      label: 'Español',
      lang: 'es'
    },
    en: {
      label: 'English',
      lang: 'en'
    }
  }
});

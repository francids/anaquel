import type { Theme } from 'vitepress';
import DefaultTheme from 'vitepress/theme';
import './style.css';

export default {
  extends: DefaultTheme,
  Layout: DefaultTheme.Layout,
} satisfies Theme;

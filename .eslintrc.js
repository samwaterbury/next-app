module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: ["eslint:recommended", "plugin:react/recommended"],
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 12,
    sourceType: "module",
  },
  plugins: ["react", "simple-import-sort"],
  rules: {
    "linebreak-style": ["error", "unix"],
    "simple-import-sort/exports": "error",
    "simple-import-sort/imports": "error",
    indent: ["error", 2],
    quotes: ["error", "double"],
    semi: ["error", "always"],
  },
  settings: { react: { version: "detect" } },
};

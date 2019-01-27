#!/usr/bin/env bash
cd frontend-vue
npm run build
rm -r ../public/*
cp -R dist/ ../public/
cd ..

# 🚀 Deployment Guide: Render & Vercel Hosting

This guide outlines how to deploy the **DonK-University ERP System** to **Render** and discusses the hosting architecture relative to **Vercel**.

---

## ☁️ 1. Deploying to Render (Recommended)

Since this is a monolithic **Spring Boot application using JSP views**, it requires a running Servlet Container (embedded Tomcat) that compiles JSPs dynamically. **Render** is the ideal choice as it supports persistent container hosting via Docker.

### 📋 Prerequisites
1. A [Render account](https://render.com/).
2. A GitHub or GitLab repository containing this project.

### 🛠️ Setup Steps
1. **Push your code to GitHub/GitLab**:
   Make sure you have pushed all your latest code, including the `Dockerfile`, `.dockerignore`, and `render.yaml` files created in the project root.
2. **Deploy using Render Blueprints (Easiest)**:
   - Go to your Render Dashboard.
   - Click **Blueprints** in the top navigation.
   - Connect your GitHub repository.
   - Render will automatically read the `render.yaml` file and deploy the service named `donk-university-erp` with all variables pre-configured.
3. **Alternative Manual Setup**:
   - Go to your Render Dashboard.
   - Click **New +** -> **Web Service**.
   - Connect your repository.
   - Select **Runtime: Docker**.
   - Set the instance plan to **Free**.
   - Render will automatically use the `Dockerfile` to build and serve the application on port `8888` (bound to `PORT` variable).

---

## ⚡ 2. Hosting on Vercel (Compatibility Context)

### ⚠️ Monolithic JSP Apps on Vercel
- **Why JSPs cannot run natively on Vercel**:
  - Vercel is designed for static frontends, single page applications (SPAs), and serverless functions (like Node.js/Next.js).
  - A server-side JSP application needs a persistent JVM/Tomcat environment to dynamically compile `.jsp` files and manage database transactions.
  - Vercel does not support continuous running Java JVM runtimes or Docker containers.
- **The Ideal Hybrid Architecture (If Vercel is Required)**:
  - If you want a Vercel presence, you would split this monolith:
    1. **Backend**: Rewrite the controllers in Spring Boot to return JSON data (REST APIs) and host it on **Render**.
    2. **Frontend**: Build a React/Next.js single-page application hosted on **Vercel**, which queries the Render REST APIs.
  - Since the current project is a classic Spring Boot + JSP application, it must be hosted **in its entirety on Render**.

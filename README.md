![CI](https://github.com/lgabrielgr/ror-task-mate/actions/workflows/ci.yml/badge.svg)

# TaskMate (ror-task-mate)

TaskMate is a collaborative task management application built with Ruby on Rails. This is a sample project designed to organize tasks, assign them to team members, and collaborate in a shared workspace.

---

## Features

### Core Features
- **User Authentication**: Secure login, logout, and registration for users.
- **Task Management**: Create, edit, delete, and view tasks with attributes like:
    - Title
    - Description
    - Due Date
    - Status (To Do, In Progress, Completed).
- **Team Collaboration**:
    - Create and manage teams.
    - Invite users to join teams.
    - Assign tasks to specific team members.
- **Authorization**:
    - Only team members can manage or view their team's tasks.
    - Role-based permissions (e.g., admin vs member).
- **Task Comments**: Add comments to tasks for discussions and updates.

### Optional Advanced Features
- **Notifications**: Email or in-app notifications for task updates.
- **Search and Filters**: Search tasks by keywords or filter by status, due date, or assignee.
- **API Integration**: Expose tasks and team data through a RESTful API.

---

## Tech Stack

- **Backend**: Ruby on Rails
- **Database**: PostgreSQL
- **Authentication**: Devise gem
- **Authorization**: Pundit or CanCanCan
- **Front-End**: Rails default views with Bootstrap
- **Background Jobs**: DelayedJob ActiveRecord
- **Testing**: RSpec

---

## Getting Started

### Prerequisites

1. Ruby 3.0+ and Rails 7+ installed.
2. PostgreSQL installed and running.
   1. (Optional) Set up a new PostgreSQL user `taskmate` and any password of your preference.
3. Bundler installed (`gem install bundler`).

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/taskmate.git
   cd taskmate
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Create/Update .env file from .env.sample file and fill up your PostgreSQL and SMTP information (if using gmail see [here](https://support.google.com/accounts/answer/185833?hl=en) for apps password)
   ```bash
   cp .env.sample .env
   ```

4. Set up the database:
   ```bash
   rails db:create db:migrate
   ```
    Optionally, you can seed the database with sample data:
    ```bash
   rails db:seed
   ```

5. Start the Rails server:
   ```bash
   rails server
   ```
6. Start the Delayed Job server:
   ```bash
   bin/delayed_job start
   ```

7. Open the application in your browser at [http://localhost:3000](http://localhost:3000).

---

## Usage

### Web Application
1. **Sign up**: Create an account or log in with an existing one.
2. **Create a Team**: Navigate to the "Teams" section to create a new team.
3. **Manage Tasks**: Add tasks, assign them to team members, and update their status as they progress.
4. **Collaborate**: Use the comments feature to discuss tasks with your team.

### RESTful API
1. **Doorkepper Application**: Create a new doorkeeper application to generate a client_id and client_secret for oauth token generation.
   1. In rails console execute the following command:
   2. ```bash
      Doorkeeper::Application.create!(
      name: "ror-task-mate",
      redirect_uri: "http://localhost:3000/callback",
      scopes: "public write"
      )
      ```
2. **OAuth token**: Generate an oauth token using the client_id and client_secret (generated in previous step).
   1. ```bash
      curl -X POST -d "client_id=client_id&client_secret=client_secret&grant_type=client_credentials" http://localhost:3000/oauth/token
      ```
3. **API Endpoints**: Use the generated token to access the API endpoints.
   1. Teams:
      2. GET /api/v1/teams
      3. GET /api/v1/team/:id
      4. GET /api/v1/team/:id/tickets
---

## Project Structure

```plaintext
app/
├── controllers/    # Controllers for handling requests
├── models/         # Application models (e.g., User, Task, Team)
├── views/          # Views for rendering HTML pages
├── mailers/        # Mailers for email notifications
├── jobs/           # Background job definitions
├── policies/       # Authorization policies (e.g., Pundit)
config/
├── routes.rb       # Application routes
├── database.yml    # Database configuration
```

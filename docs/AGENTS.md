# AGENTS.md

## 1. Project Overview

This project is an internal financial management application for a car showroom.

- Platform: iOS
- Language: Swift
- UI Framework: SwiftUI
- Backend: Supabase
- Database: PostgreSQL
- Architecture: MVVM

Refer to `docs/PRD.md` as the source of truth for product requirements and business logic.

## 2. General Development Rules

- Read relevant documentation before implementing features.
- Do not make major architectural decisions without explaining the reasoning.
- Do not implement features outside the defined PRD without discussing them first.
- Prefer simple, maintainable, modular implementations.
- Avoid unnecessary dependencies.
- Do not duplicate business logic across multiple views.
- Do not introduce unnecessary abstractions.

## 3. Swift & SwiftUI Guidelines

- Use modern Swift conventions.
- Prefer SwiftUI-native components.
- Follow MVVM separation where appropriate.
- Keep views focused on presentation.
- Put business logic in appropriate services or domain layers.
- Use reusable components.
- Handle loading, error, and empty states.
- Use async/await for asynchronous operations.
- Keep UI code clean and readable.

## 4. Backend & Database Guidelines

- Use Supabase as the backend.
- Use PostgreSQL for relational data.
- Enforce authorization through Row Level Security.
- Never rely exclusively on client-side authorization.
- Never expose service-role credentials in the iOS application.
- Use database migrations for schema changes.
- Use appropriate numeric types for financial calculations.
- Preserve financial history and auditability.

## 5. Financial Business Logic

- Refer to `docs/PRD.md` for all financial formulas.
- Centralize financial calculations.
- Never use floating-point arithmetic for financial calculations.
- Validate critical financial operations on the backend.
- Ensure multi-step financial operations are atomic.
- Never silently modify or delete financial records.

## 6. Security

- Never commit credentials, API secrets, or private keys.
- Never store plaintext passwords.
- Enforce role-based access control.
- Partners must only access their assigned financial book.
- Finance users can access all partner books.

## 7. Testing

- Write unit tests for financial calculations.
- Test critical vehicle lifecycle workflows.
- Test authentication and authorization.
- Test partner data isolation.
- Test database operations and error handling.
- Test CSV and XLSX exports.

## 8. Implementation Workflow

Before implementing a major feature:

1. Understand the requirements.
2. Identify dependencies.
3. Explain the proposed implementation.
4. Identify potential edge cases.
5. Implement incrementally.
6. Run relevant tests.
7. Summarize changes and outstanding issues.


## Skill Usage and Project Intelligence

### 1. Automatically Discover and Use Relevant Skills

- Before starting a task, consider whether any installed skill is relevant to the work.
- Automatically discover and read the instructions of relevant skills before implementing the task. Do not wait for the user to explicitly request a skill.
- Prioritize using specialized skills over relying solely on general knowledge when they provide relevant workflows, coding standards, or implementation guidance.
- Use only skills that are relevant to the current task. Avoid loading unrelated skills or repeatedly reading the same skill instructions unnecessarily.
- If multiple skills are relevant, combine their guidance while resolving any conflicting instructions in favor of the project's requirements and the more task-specific guidance.

### 2. Ponytail — Code Development

- Use the **Ponytail skill** when developing, implementing, refactoring, debugging, or reviewing code.
- Read and follow its instructions before performing substantial coding work.
- Apply its recommended coding practices, development workflow, and quality checks where relevant.
- Use it especially when implementing new features, modifying existing architecture, debugging complex issues, or improving code quality.
- Do not blindly apply its recommendations if they conflict with the project's architecture, PRD, or established conventions.

### 3. Graphify — Project Knowledge and Codebase Mapping

- Use the **Graphify skill** periodically to analyze the codebase and maintain a useful map of the project's architecture, dependencies, relationships, and implementation structure.
- **Do not run Graphify when the project is first initialized or when the codebase is still empty.** There must be meaningful source code and project structure for it to analyze.
- Run it after the project has accumulated meaningful implementation, particularly after major features, architectural changes, significant refactoring, or when the existing project map may be outdated.
- Use the generated project map to understand existing components and dependencies before making changes. This helps avoid unnecessary codebase exploration and repeated reading of files.
- Prefer updating or refreshing the existing Graphify map rather than rebuilding it unnecessarily.
- Use the map as a navigation and context-saving aid, not as a replacement for inspecting actual source code when implementation details need verification.
- Do not run Graphify after every small code change. Use it strategically to keep project knowledge useful without wasting tokens or execution time.

### 4. SwiftUI Pro — SwiftUI Development and Design

- Use the **SwiftUI Pro skill** whenever designing, implementing, or improving SwiftUI interfaces.
- Read and follow its instructions before substantial SwiftUI UI development.
- Apply its guidance for modern SwiftUI architecture, reusable components, layout composition, state management, animations, accessibility, and platform conventions where relevant.
- Prioritize polished, professional, production-quality UI rather than basic default-looking layouts.
- Maintain consistent design language across the application, including typography, spacing, colors, component styles, navigation, and interaction patterns.
- Consider different screen sizes, loading states, empty states, error states, and user interactions.
- Avoid introducing unnecessary visual complexity or inconsistent design patterns.
- Ensure that visual improvements do not compromise existing business logic, data integrity, or application architecture.

### 5. General Skill Execution Rules

- Skills provide specialized guidance; they do not override the PRD, security requirements, or explicit user instructions.
- Before implementing a feature, identify which skills are relevant and load only those needed.
- For a task involving both SwiftUI UI and backend implementation, use SwiftUI Pro for the interface and Ponytail for the coding workflow. Use other relevant skills when appropriate.
- Use Graphify when the project has enough implementation to benefit from an updated codebase map.
- Do not spend excessive tokens repeatedly loading skill documentation or generating project maps.
- If a relevant skill is unavailable, continue using sound engineering practices and inform the user only when its absence materially affects the task.

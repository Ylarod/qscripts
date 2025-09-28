# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# QScripts - IDA Pro Productivity Plugin

QScripts is an IDA Pro plugin that enables automatic script execution upon file changes, supporting hot-reload development workflows with Python, IDC, and compiled plugins.

## Build Commands

### Prerequisites
- **IDASDK**: Environment variable must be set to IDA SDK path
- **IDAX**: Must be installed at `$IDASDK/include/idax/`
- **ida-cmake**: Must be installed at `$IDASDK/ida-cmake/`

### Build with ida-cmake agent
Always use the ida-cmake agent for building:
```
Task with subagent_type="ida-cmake"
```

### Manual build (Windows)
```bash
# Configure CMake
prep-cmake.bat

# Build
prep-cmake.bat build

# Clean build
prep-cmake.bat clean
```

## Architecture

### Core Components

**Main Plugin (`qscripts.cpp`)**
- Implements `qscripts_chooser_t`: Non-modal chooser UI for script management
- File monitoring system with configurable intervals (default 500ms)
- Dependency tracking and automatic reloading
- Integration with IDA's recent scripts system (shares same list)

**Script Management (`script.hpp`)**
- `fileinfo_t`: File metadata and modification tracking
- `script_info_t`: Script state management (active/inactive/dependency)
- `active_script_info_t`: Extends script_info with dependency handling
- Dependency resolution with recursive parsing and cycle detection

### Key Features Implementation

**Dependency System**
- Dependencies defined in `.deps.qscripts` files
- Supports `/reload` directive for Python module reloading
- `/triggerfile` directive for custom trigger conditions
- `/notebook` mode for cell-based execution
- Variable expansion: `$basename$`, `$env:VAR$`, `$pkgbase$`, `$ext$`

**File Monitoring**
- Uses qtimer-based polling (not OS-specific watchers yet)
- Monitors active script and all dependencies
- Trigger file support for compiled plugin development

## IDA SDK and API Resources

When answering SDK/API questions, search and read from:
- **SDK Headers**: `$IDASDK/include` - All headers have docstrings
- **SDK Examples**: `$IDASDK/plugins`, `$IDASDK/loaders`, `$IDASDK/module`

## Testing

Test scripts are located in `test_scripts/`:
- `dependency-test/` - Simple dependency examples
- `pkg-dependency/` - Package dependency examples
- `notebooks/` - Notebook mode examples
- `trigger-native/` - Compiled plugin hot-reload examples

## Plugin States

Scripts can be in three states:
1. **Normal**: Shown in regular font
2. **Active** (bold): Currently monitored for changes
3. **Inactive** (italics): Previously active but monitoring disabled

## Important Implementation Notes

- Plugin uses IDAX framework for enhanced UI capabilities
- Shares script list with IDA's built-in "Recent Scripts" (Alt-F9)
- Maximum 512 scripts in list (IDA_MAX_RECENT_SCRIPTS)
- Special unload function: `__quick_unload_script` called before reload
- Supports undo via IDA's undo system when enabled in options
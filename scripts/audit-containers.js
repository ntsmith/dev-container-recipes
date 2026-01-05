#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const CONTAINER_DIRS = [
  'databases/duckdb',
  'databases/mariadb',
  'databases/mongodb',
  'databases/redis',
  'jupyter/jupyter_ubuntu',
  'jupyter/jupyter_ubuntu_old',
  'jekyll/jekyll_markdown',
  'jekyll/jekyll_minimal',
  'kafka',
  'languages/python/poetry_hello',
  'languages/python/python',
  'languages/python/python_autopep8',
  'languages/python/python_autopep8_pylint',
  'languages/python/python_jupyter',
  'languages/python/python_tabsize',
  'languages/python/python_venv',
  'basics/ubuntu/ubuntu',
  'basics/ubuntu/ubuntu_ms',
  'basics/ubuntu/ubuntu_user',
  'basics/alpine/alpine_git',
  'basics/alpine/alpine_tabsize',
  'basics/alpine/alpine_user',
  'ais/claude',
];

const BASE_IMAGES = ['alpine', 'debian', 'ubuntu', 'mcr.microsoft.com/devcontainers'];

const DEMO_EXTENSIONS = ['.sh', '.sql', '.js', '.ts', '.py', '.ipynb', '.go', '.rs', '.java', '.rb'];

function fileExists(filePath) {
  try {
    return fs.existsSync(filePath);
  } catch {
    return false;
  }
}

function findDemoFile(containerPath) {
  try {
    const files = fs.readdirSync(containerPath);
    for (const file of files) {
      const ext = path.extname(file).toLowerCase();
      if (DEMO_EXTENSIONS.includes(ext)) {
        return file;
      }
      if (file.toLowerCase().startsWith('demo') || file.toLowerCase().startsWith('example')) {
        return file;
      }
    }
  } catch {
    return null;
  }
  return null;
}

function usesBaseImage(containerPath) {
  const devcontainerJson = path.join(containerPath, '.devcontainer', 'devcontainer.json');
  if (!fileExists(devcontainerJson)) return false;

  try {
    const content = fs.readFileSync(devcontainerJson, 'utf8');
    const config = JSON.parse(content);

    if (config.image) {
      return BASE_IMAGES.some(base => config.image.includes(base));
    }
  } catch {
    return false;
  }
  return false;
}

function needsDockerCompose(containerPath) {
  const devcontainerJson = path.join(containerPath, '.devcontainer', 'devcontainer.json');
  if (!fileExists(devcontainerJson)) return false;

  try {
    const content = fs.readFileSync(devcontainerJson, 'utf8');
    const config = JSON.parse(content);
    return !!config.dockerComposeFile;
  } catch {
    return false;
  }
}

function hasDockerCompose(containerPath) {
  return fileExists(path.join(containerPath, 'docker-compose.yml')) ||
         fileExists(path.join(containerPath, 'docker-compose.yaml')) ||
         fileExists(path.join(containerPath, '.devcontainer', 'docker-compose.yml')) ||
         fileExists(path.join(containerPath, '.devcontainer', 'docker-compose.yaml'));
}

function auditContainer(containerPath) {
  const fullPath = path.join(process.cwd(), containerPath);

  if (!fileExists(fullPath)) {
    return { path: containerPath, exists: false, issues: ['Container directory not found'] };
  }

  const issues = [];
  const present = [];

  // Check devcontainer.json
  const hasDevcontainerJson = fileExists(path.join(fullPath, '.devcontainer', 'devcontainer.json'));
  if (hasDevcontainerJson) {
    present.push('devcontainer.json');
  } else {
    issues.push('Missing .devcontainer/devcontainer.json');
  }

  // Check Dockerfile (optional if using base image)
  const hasDockerfile = fileExists(path.join(fullPath, '.devcontainer', 'Dockerfile'));
  const usesBase = usesBaseImage(fullPath);
  if (hasDockerfile) {
    present.push('Dockerfile');
  } else if (!usesBase) {
    issues.push('Missing .devcontainer/Dockerfile (or use a base image)');
  } else {
    present.push('Dockerfile (using base image)');
  }

  // Check docker-compose.yml (only if referenced)
  const needsCompose = needsDockerCompose(fullPath);
  const hasCompose = hasDockerCompose(fullPath);
  if (needsCompose && !hasCompose) {
    issues.push('Missing docker-compose.yml (referenced in devcontainer.json)');
  } else if (hasCompose) {
    present.push('docker-compose.yml');
  }

  // Check README.md
  if (fileExists(path.join(fullPath, 'README.md'))) {
    present.push('README.md');
  } else {
    issues.push('Missing README.md');
  }

  // Check .gitignore
  if (fileExists(path.join(fullPath, '.gitignore'))) {
    present.push('.gitignore');
  } else {
    issues.push('Missing .gitignore');
  }

  // Check demo file
  const demoFile = findDemoFile(fullPath);
  if (demoFile) {
    present.push(`demo: ${demoFile}`);
  } else {
    issues.push('Missing demo file');
  }

  return {
    path: containerPath,
    exists: true,
    compliant: issues.length === 0,
    present,
    issues,
  };
}

function printResults(results) {
  const compliant = results.filter(r => r.compliant);
  const nonCompliant = results.filter(r => !r.compliant && r.exists);
  const missing = results.filter(r => !r.exists);

  console.log('\n========================================');
  console.log('    DEVCONTAINER COMPLIANCE AUDIT');
  console.log('========================================\n');

  console.log(`Total: ${results.length} containers`);
  console.log(`✅ Compliant: ${compliant.length}`);
  console.log(`⚠️  Non-compliant: ${nonCompliant.length}`);
  console.log(`❌ Not found: ${missing.length}`);
  console.log('');

  if (compliant.length > 0) {
    console.log('--- COMPLIANT CONTAINERS ---');
    for (const r of compliant) {
      console.log(`  ✅ ${r.path}`);
    }
    console.log('');
  }

  if (nonCompliant.length > 0) {
    console.log('--- NON-COMPLIANT CONTAINERS ---');
    for (const r of nonCompliant) {
      console.log(`  ⚠️  ${r.path}`);
      for (const issue of r.issues) {
        console.log(`      - ${issue}`);
      }
    }
    console.log('');
  }

  if (missing.length > 0) {
    console.log('--- NOT FOUND ---');
    for (const r of missing) {
      console.log(`  ❌ ${r.path}`);
    }
    console.log('');
  }

  // Summary by issue type
  const issueCounts = {};
  for (const r of nonCompliant) {
    for (const issue of r.issues) {
      issueCounts[issue] = (issueCounts[issue] || 0) + 1;
    }
  }

  if (Object.keys(issueCounts).length > 0) {
    console.log('--- ISSUE SUMMARY ---');
    const sorted = Object.entries(issueCounts).sort((a, b) => b[1] - a[1]);
    for (const [issue, count] of sorted) {
      console.log(`  ${count}x ${issue}`);
    }
    console.log('');
  }

  return nonCompliant.length === 0 && missing.length === 0;
}

// Discover containers dynamically
function discoverContainers(rootDir) {
  const containers = [];

  function scanDir(dir, depth = 0) {
    if (depth > 3) return;

    try {
      const devcontainerPath = path.join(dir, '.devcontainer');
      if (fileExists(devcontainerPath) && fileExists(path.join(devcontainerPath, 'devcontainer.json'))) {
        const relativePath = path.relative(rootDir, dir);
        if (relativePath && !relativePath.startsWith('devcontainers_old')) {
          containers.push(relativePath || '.');
        }
      }

      const entries = fs.readdirSync(dir, { withFileTypes: true });
      for (const entry of entries) {
        if (entry.isDirectory() && !entry.name.startsWith('.') && entry.name !== 'node_modules') {
          scanDir(path.join(dir, entry.name), depth + 1);
        }
      }
    } catch {
      // Skip inaccessible directories
    }
  }

  scanDir(rootDir);
  return containers;
}

// Main
const args = process.argv.slice(2);
const useDiscovery = args.includes('--discover');

let containersToAudit;
if (useDiscovery) {
  console.log('Discovering containers...');
  containersToAudit = discoverContainers(process.cwd());
  console.log(`Found ${containersToAudit.length} containers\n`);
} else {
  containersToAudit = CONTAINER_DIRS;
}

const results = containersToAudit.map(auditContainer);
const allPassed = printResults(results);

process.exit(allPassed ? 0 : 1);

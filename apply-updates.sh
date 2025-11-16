#!/usr/bin/env bash
set -euo pipefail

# Configuration
BRANCH="feature/all-updates"

echo "Preparing to create branch: ${BRANCH}"
git fetch origin
git checkout -B "${BRANCH}"

# Create directories
mkdir -p .github/workflows src/components/Header src/components/Layout src/components/CosmicBackground src/components/Editor src/components/Quiz src/pages/Home src/pages/Courses src/pages/Lesson src/data/lessons src/hooks

# Write files
cat > .editorconfig <<'EOF'
root = true
indent_style = space
indent_size = 2
end_of_line = lf
insert_final_newline = true
charset = utf-8
EOF

cat > .prettierrc <<'EOF'
{"semi": true,"singleQuote": true,"trailingComma": "es5","printWidth": 100}
EOF

cat > .eslintrc.cjs <<'EOF'
module.exports = {
  root: true,
  env: {
    browser: true,
    es2021: true,
    node: true
  },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended'
  ],
  parserOptions: {
    ecmaFeatures: { jsx: true },
    ecmaVersion: 'latest',
    sourceType: 'module'
  },
  settings: { react: { version: 'detect' } },
  rules: {
    'no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
    'react/react-in-jsx-scope': 'off'
  }
};
EOF

cat > .gitignore <<'EOF'
node_modules
dist
.env
.vscode
.DS_Store
EOF

cat > package.json <<'EOF'
{
  "name": "leraning-website",
  "version": "0.1.0",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "lint": "eslint . --ext .js,.jsx",
    "format": "prettier --write \"src/**/*.{js,jsx,css,md}\"",
    "test": "vitest"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.20.1"
  },
  "devDependencies": {
    "vite": "^5.0.0",
    "@vitejs/plugin-react": "^5.0.0",
    "eslint": "^8.0.0",
    "eslint-plugin-react": "^7.0.0",
    "prettier": "^2.0.0",
    "vitest": "^0.34.0",
    "@testing-library/react": "^14.0.0",
    "@testing-library/jest-dom": "^6.0.0"
  }
}
EOF

mkdir -p .github/workflows
cat > .github/workflows/ci.yml <<'EOF'
name: CI
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Use Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run lint
      - run: npm run test -- --run
      - run: npm run build
EOF

cat > README.md <<'EOF'
# Leraning_Website

This is the frontend for the university project.

Development
1. npm install
2. npm run dev

Branches
- feature/all-updates (contains a full update baseline: components, lesson schema, editor, quiz, CI)
EOF

cat > CONTRIBUTING.md <<'EOF'
# Contributing

Please follow the branch naming conventions: feature/, bugfix/, chore/. Run tests and lint before opening PRs.
EOF

# src files
cat > src/main.jsx <<'EOF'
import React from 'react';
import { createRoot } from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import App from './App.jsx';
import './global.css';

createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </React.StrictMode>
);
EOF

cat > src/App.jsx <<'EOF'
import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Layout from './components/Layout/Layout.jsx';
import Home from './pages/Home/Home.jsx';
import Courses from './pages/Courses/Courses.jsx';
import Lesson from './pages/Lesson/Lesson.jsx';

export default function App() {
  return (
    <Layout>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/courses" element={<Courses />} />
        <Route path="/lesson/:id" element={<Lesson />} />
      </Routes>
    </Layout>
  );
}
EOF

cat > src/global.css <<'EOF'
:root{
  --bg-1:#071226;
  --bg-2:#0f172a;
  --card:#0b1220;
  --accent-1:#7f00ff;
  --accent-2:#00d2ff;
  --muted:#94a3b8;
}
*{box-sizing:border-box}
html,body,#root{height:100%}
body{margin:0;font-family:Inter,system-ui,Arial;background:linear-gradient(180deg,var(--bg-1),var(--bg-2));color:#fff}
.container{max-width:1100px;margin:0 auto;padding:24px}
.header{display:flex;justify-content:space-between;align-items:center;padding:12px 0}
.nav a{color:var(--muted);margin-left:16px;text-decoration:none}
EOF

mkdir -p src/components/Layout
cat > src/components/Layout/Layout.jsx <<'EOF'
import React from 'react';
import Header from '../Header/Header.jsx';
import CosmicBackground from '../CosmicBackground/CosmicBackground.jsx';

export default function Layout({ children }) {
  return (
    <>
      <CosmicBackground />
      <div className="container">
        <Header />
        <main>{children}</main>
      </div>
    </>
  );
}
EOF

mkdir -p src/components/Header
cat > src/components/Header/Header.jsx <<'EOF'
import React from 'react';
import { Link } from 'react-router-dom';

export default function Header() {
  return (
    <header className="header">
      <div style={{display:'flex',alignItems:'center',gap:12}}>
        <svg width="44" height="44" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
          <circle cx="32" cy="32" r="30" fill="url(#g)" />
          <defs>
            <linearGradient id="g" x1="0" x2="1">
              <stop offset="0" stopColor="#7f00ff" />
              <stop offset="1" stopColor="#00d2ff" />
            </linearGradient>
          </defs>
        </svg>
        <div>
          <div style={{fontWeight:800}}>Leraning Website</div>
          <div style={{fontSize:12,color:'var(--muted)'}}>Learn like Khan • Build like Udemy</div>
        </div>
      </div>
      <nav className="nav">
        <Link to="/">Home</Link>
        <Link to="/courses">Courses</Link>
      </nav>
    </header>
  );
}
EOF

mkdir -p src/components/CosmicBackground
cat > src/components/CosmicBackground/CosmicBackground.jsx <<'EOF'
import React from 'react';
const random = (min, max) => Math.random() * (max - min) + min;
export default function CosmicBackground() {
  const stars = Array.from({ length: 20 }).map(() => ({
    left: random(0, 100),
    top: random(0, 100),
    size: random(1, 6),
    dur: random(6, 18)
  }));
  return (
    <div style={{position:'fixed',inset:0,zIndex:-1,pointerEvents:'none'}}>
      {stars.map((s,i)=> (
        <div key={i} style={{position:'absolute',left:`${s.left}%`,top:`${s.top}%`,width:s.size,height:s.size,borderRadius:'50%',background:'radial-gradient(circle,#fff,#fff0)',boxShadow:`0 0 ${s.size*2}px rgba(127,0,255,0.35)`,opacity:0.9,animation:`floaty ${s.dur}s ease-in-out infinite`}} />
      ))}
      <style>{`@keyframes floaty{0%{transform:translateY(0)}50%{transform:translateY(-8px)}100%{transform:translateY(0)}}`} </style>
    </div>
  );
}
EOF

mkdir -p src/pages/Home
cat > src/pages/Home/Home.jsx <<'EOF'
import React from 'react';
import { Link } from 'react-router-dom';

export default function Home(){
  return (
    <section>
      <div style={{display:'flex',gap:24,alignItems:'center',padding:'48px 0'}}>
        <div style={{flex:1}}>
          <h1 style={{fontSize:40,margin:0}}>Learn programming with interactive lessons</h1>
          <p style={{color:'var(--muted)'}}>Interactive editor, quizzes and projects — built for learners.</p>
          <Link to="/courses" style={{display:'inline-block',marginTop:12,padding:'10px 18px',borderRadius:10,background:'linear-gradient(90deg,var(--accent-1),var(--accent-2))',color:'#fff',textDecoration:'none'}}>Browse Courses</Link>
        </div>
      </div>
      <section>
        <h2>Popular Courses</h2>
        <div style={{display:'grid',gridTemplateColumns:'repeat(auto-fit,minmax(220px,1fr))',gap:16}}>
          {[1,2,3,4].map(i=> (
            <article key={i} style={{background:'var(--card)',padding:16,borderRadius:12}}>
              <div style={{fontWeight:700}}>Course {i}</div>
              <p style={{color:'var(--muted)'}}>Short description.</p>
            </article>
          ))}
        </div>
      </section>
    </section>
  )
}
EOF

mkdir -p src/pages/Courses
cat > src/pages/Courses/Courses.jsx <<'EOF'
import React from 'react';
import lessons from '../../data/lessons/index.js';

export default function Courses(){
  return (
    <section>
      <h1>All Courses</h1>
      <div style={{display:'grid',gridTemplateColumns:'repeat(auto-fit,minmax(220px,1fr))',gap:16,marginTop:12}}>
        {lessons.map((l)=> (
          <div key={l.id} style={{background:'var(--card)',padding:16,borderRadius:12}}>
            <div style={{fontWeight:800}}>{l.title}</div>
            <div style={{color:'var(--muted)'}}>{l.description}</div>
          </div>
        ))}
      </div>
    </section>
  )
}
EOF

mkdir -p src/pages/Lesson
cat > src/pages/Lesson/Lesson.jsx <<'EOF'
import React from 'react';
import { useParams } from 'react-router-dom';
import lessons from '../../data/lessons/index.js';
import Editor from '../../components/Editor/Editor.jsx';
import Quiz from '../../components/Quiz/Quiz.jsx';

export default function Lesson(){
  const { id } = useParams();
  const lesson = lessons.find(l=> l.id === id) || lessons[0];
  return (
    <section>
      <h1>{lesson.title}</h1>
      <div dangerouslySetInnerHTML={{__html: lesson.content}} />
      <h2>Try it</h2>
      <Editor defaultHtml={lesson.exampleHtml || ''} />
      {lesson.quiz && (
        <>
          <h2>Quiz</h2>
          <Quiz questions={lesson.quiz} />
        </>
      )}
    </section>
  )
}
EOF

mkdir -p src/components/Editor
cat > src/components/Editor/Editor.jsx <<'EOF'
import React, { useState, useRef } from 'react';
export default function Editor({ defaultHtml = '' }){
  const [code, setCode] = useState(defaultHtml);
  const iframeRef = useRef(null);
  const run = ()=>{
    const doc = iframeRef.current.contentDocument;
    doc.open();
    doc.write(code);
    doc.close();
  }
  return (
    <div style={{display:'grid',gridTemplateColumns:'1fr 1fr',gap:12,marginTop:12}}>
      <textarea value={code} onChange={e=>setCode(e.target.value)} style={{width:'100%',height:300,padding:12,borderRadius:8,background:'rgba(0,0,0,0.05)',color:'#fff'}} />
      <div>
        <div style={{marginBottom:8}}><button onClick={run} style={{padding:'8px 12px',borderRadius:8,background:'linear-gradient(90deg,var(--accent-1),var(--accent-2))',border:0,color:'#fff'}}>Run</button></div>
        <iframe title="preview" ref={iframeRef} sandbox="allow-scripts allow-same-origin" style={{width:'100%',height:300,borderRadius:8,border:'1px solid rgba(255,255,255,0.04)'}} />
      </div>
    </div>
  )
}
EOF

mkdir -p src/components/Quiz
cat > src/components/Quiz/Quiz.jsx <<'EOF'
import React, { useState } from 'react';
export default function Quiz({ questions = [] }){
  const [answers, setAnswers] = useState({});
  const [submitted, setSubmitted] = useState(false);
  const score = Object.keys(answers).reduce((acc,k)=> acc + (answers[k] === questions.find(q=>q.id===k).answer ? 1:0),0);
  const handleChange=(id,val)=> setAnswers(prev=> ({...prev,[id]: val}));
  return (
    <div>
      {questions.map(q=> (
        <div key={q.id} style={{marginBottom:12}}>
          <div style={{fontWeight:700}}>{q.text}</div>
          {q.options.map(o=> (
            <label key={o} style={{display:'block',color:'var(--muted)'}}><input type="radio" name={q.id} onChange={()=>handleChange(q.id,o)} /> {o}</label>
          ))}
        </div>
      ))}
      <button onClick={()=>setSubmitted(true)} style={{padding:'8px 12px',borderRadius:8,background:'linear-gradient(90deg,var(--accent-1),var(--accent-2))',border:0,color:'#fff'}}>Submit</button>
      {submitted && <div style={{marginTop:12}}>Score: {score}/{questions.length}</div>}
    </div>
  )
}
EOF

cat > src/data/lessons/index.js <<'EOF'
const lessons = [
  {
    id: 'lesson-1',
    title: 'Intro to HTML',
    description: 'Basics of HTML',
    content: '<p>Learn HTML basics.</p>',
    exampleHtml: '<!doctype html><html><body><h1>Hello</h1></body></html>',
    quiz: [
      { id: 'q1', text: 'What tag is for a paragraph?', options: ['<p>','<div>','<span>'], answer: '<p>' }
    ]
  }
];
export default lessons;
EOF

cat > src/data/lessons/lesson-1.json <<'EOF'
{"id":"lesson-1","title":"Intro to HTML","description":"Basics of HTML","content":"<p>Learn HTML basics.</p>","exampleHtml":"<!doctype html><html><body><h1>Hello</h1></body></html>","quiz":[{"id":"q1","text":"What tag is for a paragraph?","options":["<p>","<div>","<span>"],"answer":"<p>"}]}
EOF

cat > src/hooks/useProgress.js <<'EOF'
import { useState, useEffect } from 'react';
const KEY = 'lh_progress_v1';
export default function useProgress(){
  const [progress, setProgress] = useState(()=> { try{ return JSON.parse(localStorage.getItem(KEY))||{} }catch(e){return {} } });
  useEffect(()=>{ localStorage.setItem(KEY,JSON.stringify(progress)) },[progress]);
  const markDone = (lessonId)=> setProgress(prev=> ({...prev,[lessonId]: true}));
  return {progress, markDone};
}
EOF

cat > src/main.test.jsx <<'EOF'
import { render } from '@testing-library/react';
import App from './App.jsx';
import React from 'react';
test('renders without crashing', ()=>{ render(<App />) })
EOF

cat > vite.config.js <<'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
export default defineConfig({
  plugins: [react()],
  base: '/'
})
EOF

echo "Installing dependencies..."
npm ci

echo "Running lint (may show warnings)..."
npm run lint || echo "Lint finished with issues (check output)."

echo "Running tests..."
npm run test -- --run || echo "Tests failed or produced errors; check output above."

echo "Building..."
npm run build || echo "Build failed; check output above."

echo "Committing changes..."
git add .
git commit -m "feature: all updates — baseline, UI, lesson/quiz, editor, CI, tests" || echo "Nothing to commit or commit failed."
git push -u origin "${BRANCH}" || echo "Push failed; ensure you have push access and the remote exists."

echo "Done. If the push succeeded, branch ${BRANCH} is on origin. Open a PR to merge into main."
EOF

3) After you run the script
- Paste the terminal output here if anything errors. I will analyze it and provide exact fixes and updated files.
- If the script completes and pushes the branch, tell me and I’ll: (a) produce a PR description, acceptance criteria, and checklist; (b) run through any requested changes to the branch.

If you prefer, I can instead produce:
- a single git-format patch you can apply with git apply; or
- a zipped archive of the new files for manual extraction.

Which do you want me to do right now?
- If you want me to proceed, run the safety steps + save and run the script. Paste the terminal output here and I’ll continue.

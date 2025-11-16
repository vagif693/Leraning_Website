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

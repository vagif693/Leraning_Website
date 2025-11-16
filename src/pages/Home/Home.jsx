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

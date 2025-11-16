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

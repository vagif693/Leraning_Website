import React from 'react'
import { Link } from 'react-router-dom'

export default function Home(){
  return (
    <section>
      <div className="hero">
        <div style={{flex:1}}>
          <h1 className="title">Master programming with interactive lessons</h1>
          <p className="lead">A collaborative learning experience inspired by Khan Academy and Udemy — interactive exercises, curated courses, and community projects.</p>
          <Link to="/courses" className="cta">Browse Courses</Link>
        </div>
        <div className="hero-card" style={{width:420}}>
          <h3 style={{marginTop:0}}>Featured Course</h3>
          <div style={{display:'flex',alignItems:'center',gap:12}}>
            <div style={{width:64,height:64,borderRadius:10,background:'linear-gradient(90deg,var(--accent-1),var(--accent-2))'}}/>
            <div>
              <div style={{fontWeight:700}}>Full-Stack JS Project</div>
              <div style={{color:'var(--muted)'}}>Build real apps with React, Node and Deploy</div>
            </div>
          </div>
          <div className="grid" style={{marginTop:16}}>
            <div className="card">Interactive editor • Quizzes</div>
            <div className="card">Project-based</div>
            <div className="card">Certificates</div>
          </div>
        </div>
      </div>

      <section style={{marginTop:28}}>
        <h2 style={{marginBottom:12}}>Popular Courses</h2>
        <div className="grid">
          {[1,2,3,4].map(i=> (
            <article key={i} className="card">
              <div style={{display:'flex',justifyContent:'space-between',alignItems:'center'}}>
                <div style={{fontWeight:800}}>Course {i}</div>
                <div className="course-badge">Beginner</div>
              </div>
              <p style={{color:'var(--muted)'}}>Short description of the course and learning outcomes.</p>
            </article>
          ))}
        </div>
      </section>

      <footer className="footer">© {new Date().getFullYear()} Leraning Website — crafted with cosmic vibes</footer>
    </section>
  )
}
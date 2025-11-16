import React from 'react'

export default function Courses(){
  return (
    <section>
      <h1>All Courses</h1>
      <div className="grid" style={{marginTop:14}}>
        {Array.from({length:8}).map((_,i)=> (
          <div key={i} className="card">
            <div style={{fontWeight:800}}>Course Title {i+1}</div>
            <div style={{color:'var(--muted)'}}>Short course description that entices students.</div>
          </div>
        ))}
      </div>
    </section>
  )
}
import React from 'react'

const random = (min,max)=> Math.random()*(max-min)+min

export default function CosmicBackground(){
  const stars = Array.from({length:16}).map((_,i)=>({
    left: random(0,100),
    top: random(0,100),
    size: random(2,8),
    delay: random(0,5),
    dur: random(8,18)
  }))

  return (
    <div className="cosmic" aria-hidden>
      {stars.map((s,i)=> (
        <div key={i} className={`star animate-slow`} style={{
          left:`${s.left}%`,top:`${s.top}%`,width:s.size,height:s.size,opacity:0.9,animationDuration:`${s.dur}s`,animationDelay:`${s.delay}s`,boxShadow:`0 0 ${s.size*2}px rgba(127,0,255,0.4)`
        }} />
      ))}
    </div>
  )
}
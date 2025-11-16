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

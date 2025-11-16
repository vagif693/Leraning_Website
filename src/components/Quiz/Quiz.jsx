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

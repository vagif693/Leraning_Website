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

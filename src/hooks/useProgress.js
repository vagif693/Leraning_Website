import { useState, useEffect } from 'react';
const KEY = 'lh_progress_v1';
export default function useProgress(){
  const [progress, setProgress] = useState(()=> { try{ return JSON.parse(localStorage.getItem(KEY))||{} }catch(e){return {} } });
  useEffect(()=>{ localStorage.setItem(KEY,JSON.stringify(progress)) },[progress]);
  const markDone = (lessonId)=> setProgress(prev=> ({...prev,[lessonId]: true}));
  return {progress, markDone};
}

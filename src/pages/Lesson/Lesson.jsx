import React from 'react';
import { useParams } from 'react-router-dom';
import lessons from '../../data/lessons/index.js';
import Editor from '../../components/Editor/Editor.jsx';
import Quiz from '../../components/Quiz/Quiz.jsx';

export default function Lesson(){
  const { id } = useParams();
  const lesson = lessons.find(l=> l.id === id) || lessons[0];
  return (
    <section>
      <h1>{lesson.title}</h1>
      <div dangerouslySetInnerHTML={{__html: lesson.content}} />
      <h2>Try it</h2>
      <Editor defaultHtml={lesson.exampleHtml || ''} />
      {lesson.quiz && (
        <>
          <h2>Quiz</h2>
          <Quiz questions={lesson.quiz} />
        </>
      )}
    </section>
  )
}

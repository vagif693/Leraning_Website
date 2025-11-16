import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Layout from './components/Layout/Layout.jsx';
import Home from './pages/Home/Home.jsx';
import Courses from './pages/Courses/Courses.jsx';
import Lesson from './pages/Lesson/Lesson.jsx';

export default function App() {
  return (
    <Layout>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/courses" element={<Courses />} />
        <Route path="/lesson/:id" element={<Lesson />} />
      </Routes>
    </Layout>
  );
}

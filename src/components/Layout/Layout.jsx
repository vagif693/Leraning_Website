import React from 'react';
import Header from '../Header/Header.jsx';
import CosmicBackground from '../CosmicBackground/CosmicBackground.jsx';

export default function Layout({ children }) {
  return (
    <>
      <CosmicBackground />
      <div className="container">
        <Header />
        <main>{children}</main>
      </div>
    </>
  );
}

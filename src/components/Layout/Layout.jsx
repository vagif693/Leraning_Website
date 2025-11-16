import React from 'react'
import Header from '../Header/Header'
import CosmicBackground from '../CosmicBackground/CosmicBackground'

export default function Layout({children}){
  return (
    <>
      <CosmicBackground />
      <div className="container">
        <Header />
        <main>{children}</main>
      </div>
    </>
  )
}
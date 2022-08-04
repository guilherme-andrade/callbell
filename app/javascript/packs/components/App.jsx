import React from 'react';
import Cards from './Cards'
import CardForm from './CardForm'

export default function App() {
  return (
    <div className="w-full min-h-screen bg-gray-100 flex flex-col items-center justify-center">
      <div className="w-full flex items-center justify-center container">
        <CardForm />
      </div>
      <div className="container grid gap-4 grid-cols-4 w-full mt-4">
        <Cards />        
      </div>
    </div>
  );
}

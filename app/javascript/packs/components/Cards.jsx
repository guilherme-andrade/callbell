import React, { useEffect } from 'react';
import api from '../api';

const getCards = () => api.get('cards')

export default function Cards() {
  const [cards, setCards] = React.useState([]);

  useEffect(async () => {
    try {
      const response = await getCards();
      setCards(response.data);
    } catch (error) {
      console.error(error);
    }
  } , []);


  return (
    <>
      {cards.map((card, index) => (
        <article key={index} className="bg-gray-100 padding-3">
          <div className="rounded p-4 bg-white">
            <div>{card.name}</div>
            <div className="text-xs text-gray-500">Created: {card.created_at}</div>
          </div>
        </article>
      ))}
    </>
  );
}

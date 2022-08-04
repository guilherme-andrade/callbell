import React, { useState } from 'react';
import api from '../api';

const createCard = (params) => api.post('cards', params);

export default function CardForm() {
  const [name, setName] = React.useState('');

  const saveCard = async (params) => {
    try {
      const response = await createCard(params);
      console.log(response);
    } catch (error) {
      console.error(error);
    }
  }

  return (
    <div className="block w-full border-b pb-4">
      <label htmlFor="name">New Card</label>
      <div className="flex items-center py-2">
        <input
          className="block w-1/2 pl-7 pr-12 py-4 sm:text-sm border-gray-300 rounded-md mr-3"
          type="text"
          value={name}
          placeholder="Type your new card name"
          onChange={(e) => setName(e.target.value)}
          onBlur={(e) => saveCard({ name: name })}
        />
        <button
          className="py-4 sm:text-sm border-gray-300 rounded-md bg-gray-800 text-white grow-0 px-5"
          onClick={(e) => saveCard({ name: name })}
        >
          Add
        </button>
      </div>
    </div>
  );
}

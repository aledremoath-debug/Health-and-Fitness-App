'use client';

import React, { createContext, useContext, useState, useEffect, useMemo } from 'react';
import { translations } from '@/utils/translations';

const UserContext = createContext();

export function UserProvider({ children }) {
  const [userData, setUserData] = useState({
    name: 'محمد أحمد',
    email: 'user@example.com',
    phone: '+966 50 000 0000',
    age: 25,
    gender: 'male',
    weight: 70,
    height: 170,
    activityLevel: 'moderate',
    dietType: 'default',
    goal: 'maintain',
    notifications: {
      water: true,
      exercise: true,
      meals: false,
      sleep: true
    },
    language: 'ar',
    theme: 'dark'
  });

  // Derived translation object
  const t = useMemo(() => translations[userData.language] || translations.ar, [userData.language]);

  const updateUserData = (newData) => {
    setUserData(prev => ({ ...prev, ...newData }));
  };

  // Sync theme to document body
  useEffect(() => {
    const root = window.document.documentElement;
    if (userData.theme === 'light') {
      root.classList.add('light');
    } else {
      root.classList.remove('light');
    }
  }, [userData.theme]);

  // Sync language/direction to document
  useEffect(() => {
    document.documentElement.lang = userData.language;
    document.documentElement.dir = userData.language === 'ar' ? 'rtl' : 'ltr';
  }, [userData.language]);

  return (
    <UserContext.Provider value={{ userData, updateUserData, t }}>
      {children}
    </UserContext.Provider>
  );
}

export function useUser() {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error('useUser must be used within a UserProvider');
  }
  return context;
}

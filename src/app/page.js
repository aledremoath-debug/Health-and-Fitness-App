'use client';

import React, { useMemo } from 'react';
import Link from 'next/link';
import { useUser } from '@/context/UserContext';
import FormUserData from '@/components/FormUserData';
import ResultCards from '@/components/ResultCards';
import Body3D from '@/components/Body3D';
import MealsList from '@/components/MealsList';
import ExercisesList from '@/components/ExercisesList';
import UserProgress from '@/components/UserProgress';
import Notifications from '@/components/Notifications';
import Challenges from '@/components/Challenges';
import Articles from '@/components/Articles';
import Navbar from '@/components/Navbar';
import {
  calculateBMI,
  calculateBMR,
  calculateTDEE,
  calculateTargetCalories,
  calculateMacros,
  calculateWaterIntake
} from '@/utils/calculations';
import { motion } from 'framer-motion';
import { Heart, LayoutDashboard, Settings, User as UserIcon, BarChart3, Menu, Bell } from 'lucide-react';

export default function Home() {
  const { userData, updateUserData, t } = useUser();

  const results = useMemo(() => {
    const bmi = calculateBMI(userData.weight, userData.height);
    const bmr = calculateBMR(userData.gender, userData.weight, userData.height, userData.age);
    const tdee = calculateTDEE(bmr, userData.activityLevel);
    const targetCalories = calculateTargetCalories(tdee, userData.goal);
    const macros = calculateMacros(targetCalories, userData.dietType);
    const water = calculateWaterIntake(userData.weight, userData.activityLevel);

    return { bmi, bmr, tdee, targetCalories, macros, water };
  }, [userData]);

  const handleCalculate = (data) => {
    updateUserData(data);
    window.scrollTo({ top: 400, behavior: 'smooth' });
  };

  return (
    <main className="min-h-screen">
      <Notifications />

      <Navbar />

      <div className="pt-32 pb-24 px-4 md:px-12 max-w-[1600px] mx-auto" suppressHydrationWarning>
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-10">

          {/* Sidebar Area: User Stats & 3D */}
          <aside className="lg:col-span-3 space-y-10">
            <motion.div initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }}>
              <h1 className="text-5xl font-black mb-4 leading-[1.1] tracking-tighter">
                {userData.language === 'ar' ? (
                  <>صحتك، <span className="text-blue-500">بذكاء.</span></>
                ) : (
                  <>Health, <span className="text-blue-500">Smarter.</span></>
                )}
              </h1>
            </motion.div>

            <Body3D bmi={results.bmi} weight={userData.weight} height={userData.height} />

            <Challenges />
          </aside>

          {/* Main Content Area */}
          <div className="lg:col-span-6 space-y-12">
            <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
              <ResultCards results={results} />
            </motion.div>

            <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3 }}>
              <UserProgress />
            </motion.div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-10">
              <MealsList dietType={userData.dietType} />
              <ExercisesList goal={userData.goal} />
            </div>
          </div>

          {/* Right Sidebar Area: Form & Features */}
          <aside className="lg:col-span-3 space-y-10">
            <FormUserData onCalculate={handleCalculate} initialData={userData} />
            <Articles />
          </aside>

        </div>
      </div>

      {/* Footer */}
      <footer className="border-t border-[rgba(var(--surface-border))] py-12 px-8 text-center text-dim text-sm">
        <p>&copy; 2025 {t.appName} Health Systems. Luxury Fitness Redefined.</p>
        <div className="flex justify-center gap-8 mt-6 font-bold uppercase tracking-widest text-[10px]">
          <a href="#" className="hover:text-blue-500 transition-colors">Privacy</a>
          <a href="#" className="hover:text-blue-500 transition-colors">Terms</a>
          <a href="#" className="hover:text-blue-500 transition-colors">Support</a>
        </div>
      </footer>
    </main>
  );
}

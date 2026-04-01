'use client';

import React, { useState } from 'react';
import { exercisesData } from '@/utils/data';
import { motion } from 'framer-motion';
import { Dumbbell, Clock, Play, Flame } from 'lucide-react';
import { useUser } from '@/context/UserContext';
import DetailModal from './DetailModal';

const ExercisesList = ({ goal }) => {
    const { t, userData } = useUser();
    const lang = userData.language;
    const [selectedExercise, setSelectedExercise] = useState(null);

    const filteredExercises = exercisesData.filter(ex => ex.goal.includes(goal));

    return (
        <div className="space-y-6">
            <div className="flex items-center gap-3">
                <div className="p-3 bg-indigo-500/10 rounded-2xl">
                    <Dumbbell className="text-indigo-500" size={24} />
                </div>
                <div>
                    <h2 className="text-2xl font-black text-main tracking-tight">{t.exercises}</h2>
                    <p className="text-dim text-[10px] font-black uppercase tracking-widest">Built for your goal</p>
                </div>
            </div>

            <div className="space-y-4">
                {filteredExercises.map((ex, index) => (
                    <motion.div
                        key={ex.id}
                        initial={{ opacity: 0, x: 10 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: index * 0.1 }}
                        onClick={() => setSelectedExercise(ex)}
                        className="theme-card group p-3 flex items-center gap-4 hover:border-indigo-500/30 cursor-pointer overflow-hidden"
                    >
                        <div className="w-24 h-24 rounded-2xl overflow-hidden flex-shrink-0 relative">
                            <img src={ex.image} alt={ex.name[lang]} className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" />
                            <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                                <Play size={24} className="text-white fill-white" />
                            </div>
                        </div>

                        <div className="flex-grow">
                            <span className="text-[9px] font-black text-indigo-500 bg-indigo-500/10 px-2 py-0.5 rounded-md uppercase tracking-wider mb-2 inline-block">
                                {ex.muscle[lang]}
                            </span>
                            <h3 className="font-bold text-main text-sm mb-2">{ex.name[lang]}</h3>
                            <div className="flex gap-4">
                                <div className="flex items-center gap-1 text-dim text-[10px] font-bold">
                                    <Clock size={12} />
                                    {ex.duration}
                                </div>
                                <div className="flex items-center gap-1 text-dim text-[10px] font-bold">
                                    <Flame size={12} className="text-orange-500" />
                                    {ex.calories} kcal
                                </div>
                            </div>
                        </div>

                        <div className="p-3 bg-indigo-500 text-white rounded-2xl shadow-lg shadow-indigo-500/20 translate-x-12 opacity-0 group-hover:translate-x-0 group-hover:opacity-100 transition-all duration-500">
                            <Play size={16} fill="white" />
                        </div>
                    </motion.div>
                ))}
            </div>

            <DetailModal
                isOpen={!!selectedExercise}
                onClose={() => setSelectedExercise(null)}
                data={selectedExercise}
                type="exercise"
            />
        </div>
    );
};

export default ExercisesList;

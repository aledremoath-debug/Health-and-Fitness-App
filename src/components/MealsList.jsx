'use client';

import React, { useState } from 'react';
import { mealsData } from '@/utils/data';
import { motion } from 'framer-motion';
import { Flame, Utensils, Plus, ExternalLink } from 'lucide-react';
import { useUser } from '@/context/UserContext';
import DetailModal from './DetailModal';

const MealsList = ({ dietType }) => {
    const { t, userData } = useUser();
    const lang = userData.language;
    const [selectedMeal, setSelectedMeal] = useState(null);

    const filteredMeals = mealsData.filter(meal =>
        meal.type.includes(dietType) || meal.type.includes('default')
    );

    return (
        <div className="space-y-6">
            <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                    <div className="p-3 bg-blue-500/10 rounded-2xl">
                        <Utensils className="text-blue-500" size={24} />
                    </div>
                    <div>
                        <h2 className="text-2xl font-black text-main tracking-tight">{t.meals}</h2>
                        <p className="text-dim text-[10px] font-black uppercase tracking-widest">{t.active} Plan</p>
                    </div>
                </div>
            </div>

            <div className="grid grid-cols-1 gap-4">
                {filteredMeals.map((meal, index) => (
                    <motion.div
                        key={meal.id}
                        initial={{ opacity: 0, x: -10 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: index * 0.1 }}
                        onClick={() => setSelectedMeal(meal)}
                        className="theme-card group relative p-3 flex gap-4 hover:border-blue-500/30 cursor-pointer overflow-hidden"
                    >
                        <div className="w-24 h-24 rounded-2xl overflow-hidden flex-shrink-0">
                            <img src={meal.image} alt={meal.name[lang]} className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" />
                        </div>
                        <div className="flex-grow py-1 pr-2 rtl:pl-2 rtl:pr-0">
                            <h3 className="font-bold text-main mb-1 text-sm">{meal.name[lang]}</h3>
                            <div className="flex items-center gap-2 text-dim text-[10px] font-bold">
                                <Flame size={12} className="text-orange-500" />
                                <span>{meal.calories} kcal</span>
                            </div>
                            <div className="mt-4 flex items-center justify-between">
                                <span className="text-[10px] text-blue-500 font-black uppercase tracking-widest flex items-center gap-1">
                                    View Recipe <ExternalLink size={10} />
                                </span>
                                <div className="p-2 bg-white/5 group-hover:bg-blue-600 group-hover:text-white transition-all rounded-xl">
                                    <Plus size={14} />
                                </div>
                            </div>
                        </div>
                    </motion.div>
                ))}
            </div>

            <DetailModal
                isOpen={!!selectedMeal}
                onClose={() => setSelectedMeal(null)}
                data={selectedMeal}
                type="meal"
            />
        </div>
    );
};

export default MealsList;

'use client';

import React from 'react';
import { motion } from 'framer-motion';
import { Activity, Flame, Droplets, Zap } from 'lucide-react';
import { useUser } from '@/context/UserContext';

const ResultCards = ({ results }) => {
    const { t } = useUser();

    const cards = [
        { title: t.bmi, value: results.bmi, unit: '', icon: <Activity className="text-blue-500" />, color: 'from-blue-500/20 to-indigo-500/20' },
        { title: t.calories, value: results.targetCalories, unit: 'kcal', icon: <Flame className="text-orange-500" />, color: 'from-orange-500/20 to-red-500/20' },
        { title: t.water, value: results.water, unit: 'L', icon: <Droplets className="text-cyan-500" />, color: 'from-cyan-500/20 to-blue-500/20' },
        { title: t.tdee, value: results.tdee, unit: 'kcal', icon: <Zap className="text-yellow-500" />, color: 'from-yellow-500/20 to-orange-500/20' },
    ];

    const macros = [
        { label: t.protein, value: results.macros.protein, color: 'bg-emerald-500' },
        { label: t.carbs, value: results.macros.carbs, color: 'bg-blue-500' },
        { label: t.fats, value: results.macros.fats, color: 'bg-amber-500' },
    ];

    return (
        <div className="space-y-10">
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                {cards.map((card, index) => (
                    <motion.div
                        key={index}
                        initial={{ opacity: 0, scale: 0.9 }}
                        animate={{ opacity: 1, scale: 1 }}
                        transition={{ delay: index * 0.1 }}
                        className="theme-card p-6 relative overflow-hidden group"
                    >
                        <div className={`absolute inset-0 bg-gradient-to-br ${card.color} opacity-0 group-hover:opacity-100 transition-opacity duration-500`} />
                        <div className="relative z-10">
                            <div className="mb-4 bg-white/5 w-12 h-12 rounded-2xl flex items-center justify-center shadow-inner">
                                {card.icon}
                            </div>
                            <p className="text-dim text-[10px] font-black uppercase tracking-widest mb-1">{card.title}</p>
                            <div className="flex items-baseline gap-1">
                                <span className="text-3xl font-black text-main">{card.value}</span>
                                <span className="text-[10px] text-dim font-bold">{card.unit}</span>
                            </div>
                        </div>
                    </motion.div>
                ))}
            </div>

            <div className="theme-card p-8" suppressHydrationWarning>
                <div className="flex justify-between items-center mb-8">
                    <h3 className="font-bold text-xl text-main">{t.results} {t.macros}</h3>
                    <div className="text-[10px] text-dim font-black uppercase tracking-widest">Grams / Day</div>
                </div>
                <div className="space-y-8">
                    {macros.map((macro, idx) => (
                        <div key={idx}>
                            <div className="flex justify-between text-sm mb-3">
                                <span className="text-dim font-black uppercase tracking-wide text-xs">{macro.label}</span>
                                <span className="text-main font-black underline decoration-blue-500/30 underline-offset-4">{macro.value}g</span>
                            </div>
                            <div className="h-3 w-full bg-white/5 rounded-full overflow-hidden border border-white/5">
                                <motion.div
                                    initial={{ width: 0 }}
                                    animate={{ width: `${(macro.value / (results.macros.protein + results.macros.carbs + results.macros.fats)) * 100}%` }}
                                    transition={{ duration: 1.2, ease: "circOut", delay: 0.5 + idx * 0.1 }}
                                    className={`h-full ${macro.color} rounded-full shadow-lg shadow-current/20`}
                                />
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export default ResultCards;

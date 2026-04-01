'use client';

import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X, Clock, Flame, Dumbbell, Utensils } from 'lucide-react';
import { useUser } from '@/context/UserContext';

const DetailModal = ({ isOpen, onClose, data, type }) => {
    const { t, userData } = useUser();
    const lang = userData.language;

    if (!data) return null;

    return (
        <AnimatePresence>
            {isOpen && (
                <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        onClick={onClose}
                        className="fixed inset-0 bg-[rgba(var(--background),0.8)] backdrop-blur-xl"
                    />
                    <motion.div
                        initial={{ opacity: 0, scale: 0.95, y: 20 }}
                        animate={{ opacity: 1, scale: 1, y: 0 }}
                        exit={{ opacity: 0, scale: 0.95, y: 20 }}
                        className="relative w-full max-w-2xl bg-[rgb(var(--surface))] border border-[rgba(var(--surface-border))] rounded-[3rem] overflow-hidden shadow-2xl glass-effect"
                    >
                        {/* Header Image */}
                        <div className="h-72 w-full relative">
                            <img src={data.image} alt={data.name[lang]} className="w-full h-full object-cover" />
                            <div className="absolute inset-0 bg-gradient-to-t from-[rgb(var(--surface))] via-transparent to-transparent" />
                            <button
                                onClick={onClose}
                                className="absolute top-8 right-8 p-3 bg-black/40 backdrop-blur-xl rounded-2xl text-white hover:bg-black/60 transition-all shadow-lg"
                            >
                                <X size={20} />
                            </button>
                        </div>

                        {/* Content */}
                        <div className="p-10">
                            <div className="flex justify-between items-start mb-10">
                                <div>
                                    <h2 className="text-4xl font-black text-main mb-3 tracking-tighter">{data.name[lang]}</h2>
                                    <div className="flex gap-6">
                                        <div className="flex items-center gap-2 text-dim text-xs font-black uppercase tracking-widest">
                                            <Flame size={16} className="text-orange-500" />
                                            {data.calories} {t.caloriesBurn}
                                        </div>
                                        <div className="flex items-center gap-2 text-dim text-xs font-black uppercase tracking-widest">
                                            {type === 'meal' ? <Utensils size={16} className="text-blue-500" /> : <Clock size={16} className="text-indigo-500" />}
                                            {data.duration || (data.macros && `P:${data.macros.p} C:${data.macros.c} F:${data.macros.f}`)}
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div className="grid grid-cols-1 md:grid-cols-2 gap-10">
                                {/* Left Side: Ingredients/Muscle */}
                                <div>
                                    <h4 className="font-black text-main text-sm mb-6 uppercase tracking-widest flex items-center gap-3">
                                        <div className="p-2 bg-blue-500/10 rounded-xl">
                                            {type === 'meal' ? <Utensils size={18} className="text-blue-500" /> : <Dumbbell size={18} className="text-blue-500" />}
                                        </div>
                                        {type === 'meal' ? t.ingredients : t.muscle}
                                    </h4>
                                    {type === 'meal' ? (
                                        <ul className="space-y-3">
                                            {data.ingredients[lang].map((item, i) => (
                                                <li key={i} className="flex items-center gap-4 text-dim text-sm font-medium">
                                                    <div className="w-2 h-2 rounded-full bg-blue-500 shadow-[0_0_10px_rgba(59,130,246,0.5)]" />
                                                    {item}
                                                </li>
                                            ))}
                                        </ul>
                                    ) : (
                                        <div className="p-5 bg-blue-500/5 rounded-[2rem] border border-blue-500/10 inline-block">
                                            <span className="text-blue-500 font-black uppercase tracking-widest text-xs">{data.muscle[lang]}</span>
                                        </div>
                                    )}
                                </div>

                                {/* Right Side: Steps/Instructions */}
                                <div>
                                    <h4 className="font-black text-main text-sm mb-6 uppercase tracking-widest flex items-center gap-3">
                                        <div className="p-2 bg-indigo-500/10 rounded-xl">
                                            <Clock size={18} className="text-indigo-500" />
                                        </div>
                                        {type === 'meal' ? t.steps : t.instructions}
                                    </h4>
                                    <div className="space-y-6">
                                        {(data.steps?.[lang] || data.instructions?.[lang]).map((step, i) => (
                                            <div key={i} className="flex gap-4">
                                                <span className="flex-shrink-0 w-8 h-8 rounded-2xl bg-[rgb(var(--primary))] text-white flex items-center justify-center text-sm font-black shadow-lg shadow-blue-500/20">
                                                    {i + 1}
                                                </span>
                                                <p className="text-dim text-sm leading-relaxed font-medium">{step}</p>
                                            </div>
                                        ))}
                                    </div>
                                </div>
                            </div>

                            <button
                                onClick={onClose}
                                className="w-full mt-12 bg-white/5 hover:bg-white/10 text-main font-black py-5 rounded-[2rem] transition-all border border-white/5 uppercase tracking-widest text-xs"
                            >
                                {t.close}
                            </button>
                        </div>
                    </motion.div>
                </div>
            )}
        </AnimatePresence>
    );
};

export default DetailModal;

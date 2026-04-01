'use client';

import React from 'react';
import { motion } from 'framer-motion';
import { Trophy, CheckCircle2, Circle, Flame, Footprints, Droplets } from 'lucide-react';
import { useUser } from '@/context/UserContext';

const Challenges = () => {
    const { t } = useUser();

    const challenges = [
        { id: 1, title: { ar: 'تحدي الخطوات', en: 'Step Challenge' }, target: '10,000', current: '6,400', icon: <Footprints className="text-emerald-500" />, color: 'bg-emerald-500', progress: 64 },
        { id: 2, title: { ar: 'شرب المياه', en: 'Hydration Goal' }, target: '3L', current: '2.1L', icon: <Droplets className="text-blue-500" />, color: 'bg-blue-500', progress: 70 },
        { id: 3, title: { ar: 'حرق السعرات', en: 'Calorie Burn' }, target: '500', current: '320', icon: <Flame className="text-orange-500" />, color: 'bg-orange-500', progress: 64 },
    ];

    return (
        <div className="space-y-6">
            <div className="flex items-center gap-3">
                <Trophy className="text-yellow-500" size={28} />
                <h2 className="text-2xl font-bold">{t.language === 'ar' ? 'التحديات اليومية' : 'Daily Challenges'}</h2>
            </div>

            <div className="grid grid-cols-1 gap-4">
                {challenges.map((ch, idx) => (
                    <motion.div
                        key={ch.id}
                        initial={{ opacity: 0, scale: 0.95 }}
                        animate={{ opacity: 1, scale: 1 }}
                        transition={{ delay: idx * 0.1 }}
                        className="theme-card p-5 group cursor-default"
                    >
                        <div className="flex items-center justify-between mb-4">
                            <div className="flex items-center gap-4">
                                <div className="p-3 bg-white/5 rounded-2xl group-hover:scale-110 transition-transform">
                                    {ch.icon}
                                </div>
                                <div>
                                    <h4 className="font-bold text-sm">{t.language === 'ar' ? ch.title.ar : ch.title.en}</h4>
                                    <p className="text-dim text-xs mt-0.5">{ch.current} / {ch.target}</p>
                                </div>
                            </div>
                            {ch.progress === 100 ? (
                                <CheckCircle2 className="text-emerald-500" size={24} />
                            ) : (
                                <Circle className="text-dim/20" size={24} />
                            )}
                        </div>
                        <div className="h-1.5 w-full bg-white/5 rounded-full overflow-hidden">
                            <motion.div
                                initial={{ width: 0 }}
                                animate={{ width: `${ch.progress}%` }}
                                transition={{ duration: 1, ease: "easeOut" }}
                                className={`h-full ${ch.color} rounded-full`}
                            />
                        </div>
                    </motion.div>
                ))}
            </div>
        </div>
    );
};

export default Challenges;

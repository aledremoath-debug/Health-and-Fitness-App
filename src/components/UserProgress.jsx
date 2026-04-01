'use client';

import React from 'react';
import dynamic from 'next/dynamic';
import { TrendingUp, Award, Calendar } from 'lucide-react';
import { useUser } from '@/context/UserContext';

const WeightChart = dynamic(() => import('./ProgressCharts').then(mod => mod.WeightChart), {
    ssr: false,
    loading: () => <div className="w-full h-full flex items-center justify-center text-dim">Loading Analytics...</div>
});

const CaloriesChart = dynamic(() => import('./ProgressCharts').then(mod => mod.CaloriesChart), {
    ssr: false,
    loading: () => <div className="w-full h-full flex items-center justify-center text-dim">Loading Analytics...</div>
});

const mockProgress = [
    { day: 'Sat', weight: 75.0, calories: 2100 },
    { day: 'Sun', weight: 74.8, calories: 1950 },
    { day: 'Mon', weight: 74.5, calories: 2050 },
    { day: 'Tue', weight: 74.6, calories: 2200 },
    { day: 'Wed', weight: 74.2, calories: 1800 },
    { day: 'Thu', weight: 74.0, calories: 1900 },
    { day: 'Fri', weight: 73.8, calories: 2000 },
];

const UserProgress = () => {
    const { t } = useUser();

    return (
        <div className="space-y-8">
            <div className="flex items-center justify-between">
                <div className="flex items-center gap-4">
                    <div className="p-3 bg-emerald-500/10 rounded-2xl">
                        <TrendingUp className="text-emerald-500" size={28} />
                    </div>
                    <div>
                        <h2 className="text-2xl font-bold text-main">{t.progress}</h2>
                        <p className="text-dim text-xs">Visualizing your fitness journey</p>
                    </div>
                </div>
                <div className="bg-white/5 px-4 py-2 rounded-xl flex items-center gap-2 text-dim text-xs font-bold border border-white/5">
                    <Calendar size={14} />
                    <span>{t.last7Days}</span>
                </div>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <div className="theme-card p-6">
                    <h3 className="text-dim text-[10px] font-black mb-8 uppercase tracking-widest">{t.weightTrend}</h3>
                    <div className="h-[250px] w-full">
                        <WeightChart data={mockProgress} />
                    </div>
                </div>

                <div className="theme-card p-6">
                    <h3 className="text-dim text-[10px] font-black mb-8 uppercase tracking-widest">{t.calorieTrend}</h3>
                    <div className="h-[250px] w-full">
                        <CaloriesChart data={mockProgress} />
                    </div>
                </div>
            </div>

            <div className="bg-gradient-to-r from-blue-600 to-indigo-600 p-[1px] rounded-[2.5rem]">
                <div className="theme-card !bg-[rgba(var(--background),0.9)] p-6 flex flex-col md:flex-row items-center justify-between gap-6 overflow-hidden relative">
                    <div className="absolute top-0 right-0 w-32 h-32 bg-blue-500/10 blur-3xl rounded-full" />
                    <div className="flex items-center gap-6 z-10">
                        <div className="w-16 h-16 bg-blue-500 rounded-2xl shadow-xl shadow-blue-500/40 flex items-center justify-center text-white">
                            <Award size={32} />
                        </div>
                        <div>
                            <h4 className="font-black text-xl text-main tracking-tight">{t.achievement}</h4>
                            <p className="text-dim text-sm max-w-sm leading-relaxed mt-1">{t.achievementDesc}</p>
                        </div>
                    </div>
                    <button className="bg-white/5 hover:bg-white/10 px-8 py-4 rounded-2xl border border-white/10 text-main font-black text-xs uppercase tracking-widest transition-all z-10 active:scale-95 shadow-lg">
                        {t.downloadReport}
                    </button>
                </div>
            </div>
        </div>
    );
};

export default UserProgress;

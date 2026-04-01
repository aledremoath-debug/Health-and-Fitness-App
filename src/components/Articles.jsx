'use client';

import React from 'react';
import { motion } from 'framer-motion';
import { BookOpen, ArrowUpRight } from 'lucide-react';
import { useUser } from '@/context/UserContext';

const Articles = () => {
    const { t } = useUser();

    const articles = [
        { id: 1, title: { ar: 'كيف تزيد من معدل حرق الدهون؟', en: 'How to increase your metabolic rate?' }, category: { ar: 'تغذية', en: 'Nutrition' }, image: 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=500' },
        { id: 2, title: { ar: 'أفضل 5 تمارين لتقوية الظهر', en: 'Top 5 back strength exercises' }, category: { ar: 'تمارين', en: 'Workouts' }, image: 'https://images.unsplash.com/photo-1541534741688-6078c65b5a33?w=500' },
    ];

    return (
        <div className="space-y-6">
            <div className="flex items-center gap-3">
                <BookOpen className="text-blue-500" size={28} />
                <h2 className="text-2xl font-bold">{t.language === 'ar' ? 'مقالات صحية' : 'Health Insights'}</h2>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-1 gap-6">
                {articles.map((art, idx) => (
                    <motion.div
                        key={idx}
                        className="theme-card overflow-hidden group cursor-pointer"
                        whileHover={{ y: -5 }}
                    >
                        <div className="h-40 w-full relative">
                            <img src={art.image} className="w-full h-full object-cover grayscale-[20%] group-hover:grayscale-0 transition-all duration-500" alt="" />
                            <div className="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent" />
                            <span className="absolute bottom-3 right-4 rtl:left-4 rtl:right-auto bg-blue-600 text-white text-[10px] font-black uppercase px-2 py-1 rounded-md">
                                {t.language === 'ar' ? art.category.ar : art.category.en}
                            </span>
                        </div>
                        <div className="p-5">
                            <h4 className="font-bold text-sm leading-relaxed text-main group-hover:text-blue-400 transition-colors">
                                {t.language === 'ar' ? art.title.ar : art.title.en}
                            </h4>
                            <div className="mt-4 flex items-center justify-between">
                                <span className="text-xs text-dim font-medium uppercase tracking-widest">Read More</span>
                                <ArrowUpRight size={16} className="text-dim group-hover:text-blue-400 group-hover:translate-x-1 group-hover:-translate-y-1 transition-all" />
                            </div>
                        </div>
                    </motion.div>
                ))}
            </div>
        </div>
    );
};

export default Articles;

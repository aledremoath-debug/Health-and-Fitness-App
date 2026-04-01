'use client';

import React, { useRef, useMemo } from 'react';
import { Canvas, useFrame } from '@react-three/fiber';
import { OrbitControls, ContactShadows, Environment, Text } from '@react-three/drei';
import * as THREE from 'three';

const BodyMesh = ({ bmi, weight, height }) => {
    const meshRef = useRef();

    // Simple body model using a primitive (Capsule) for demonstration
    // In a production app, this would be a skinned mesh with morph targets
    const bodyScale = useMemo(() => {
        // Normal BMI is 18.5 - 25
        // Scale body thickness based on BMI
        const thickness = Math.max(0.5, Math.min(2.5, bmi / 22));
        // Scale height based on actual user height (normalized around 170cm)
        const heightScale = height / 170;
        return [thickness, heightScale, thickness];
    }, [bmi, height]);

    useFrame((state) => {
        const t = state.clock.getElapsedTime();
        if (meshRef.current) {
            // Subtle idle animation
            meshRef.current.rotation.y = Math.sin(t / 2) * 0.1;
            meshRef.current.position.y = Math.sin(t) * 0.05;
        }
    });

    return (
        <group>
            {/* Head */}
            <mesh position={[0, 0.8 * bodyScale[1], 0]}>
                <sphereGeometry args={[0.15, 32, 32]} />
                <meshStandardMaterial color="#ffdbac" />
            </mesh>

            {/* Torso */}
            <mesh ref={meshRef} position={[0, 0, 0]} scale={bodyScale}>
                <capsuleGeometry args={[0.2, 0.8, 4, 32]} />
                <meshStandardMaterial
                    color="#ffdbac"
                    roughness={0.3}
                    metalness={0.2}
                />
            </mesh>

            {/* Arms */}
            <mesh position={[-0.3 * bodyScale[0], 0.3 * bodyScale[1], 0]} rotation={[0, 0, 0.2]}>
                <capsuleGeometry args={[0.08, 0.6, 4, 16]} />
                <meshStandardMaterial color="#ffdbac" />
            </mesh>
            <mesh position={[0.3 * bodyScale[0], 0.3 * bodyScale[1], 0]} rotation={[0, 0, -0.2]}>
                <capsuleGeometry args={[0.08, 0.6, 4, 16]} />
                <meshStandardMaterial color="#ffdbac" />
            </mesh>

            {/* Legs */}
            <mesh position={[-0.15 * bodyScale[0], -0.6 * bodyScale[1], 0]}>
                <capsuleGeometry args={[0.1, 0.7, 4, 16]} />
                <meshStandardMaterial color="#ffdbac" />
            </mesh>
            <mesh position={[0.15 * bodyScale[0], -0.6 * bodyScale[1], 0]}>
                <capsuleGeometry args={[0.1, 0.7, 4, 16]} />
                <meshStandardMaterial color="#ffdbac" />
            </mesh>
        </group>
    );
};

const Body3D = ({ bmi = 22, weight = 70, height = 170 }) => {
    return (
        <div className="w-full h-[400px] bg-[rgba(var(--primary),0.05)] rounded-[3rem] overflow-hidden relative shadow-2xl border border-[rgba(var(--surface-border))] theme-card">
            <div className="absolute top-6 left-6 rtl:right-6 rtl:left-auto z-10">
                <h3 className="text-main text-sm font-black bg-white/5 backdrop-blur-xl px-4 py-2 rounded-2xl border border-white/5 shadow-lg">
                    {weight}kg | {height}cm
                </h3>
            </div>

            <Canvas shadows camera={{ position: [0, 0, 4], fov: 45 }}>
                <ambientLight intensity={1} />
                <spotLight position={[10, 10, 10]} angle={0.15} penumbra={1} intensity={2} castShadow />
                <pointLight position={[-10, -10, -10]} intensity={1} />

                <BodyMesh bmi={bmi} weight={weight} height={height} />

                <ContactShadows
                    position={[0, -1.2, 0]}
                    opacity={0.4}
                    scale={10}
                    blur={2.5}
                    far={1}
                />

                <Environment preset="city" />
                <OrbitControls
                    enablePan={false}
                    enableZoom={false}
                    minPolarAngle={Math.PI / 2.5}
                    maxPolarAngle={Math.PI / 1.5}
                />
            </Canvas>

            <div className="absolute bottom-6 right-6 rtl:left-6 rtl:right-auto text-dim text-[10px] font-black uppercase tracking-widest opacity-50">
                * Interactive 3D Preview
            </div>
        </div>
    );
};

export default Body3D;

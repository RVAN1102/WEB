/**
 * main-animation.js
 * Senior Creative Front-end Architecture
 * Stack: GSAP 3 + Three.js + Micro-interactions
 * Optimization: 60fps GPU acceleration, Lerp dampening, Zero-lag
 */

(function () {
    "use strict";

    // Khởi chạy khi DOM sẵn sàng
    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", init);
    } else {
        init();
    }

    function init() {
        initAmbient3DBackground();
        initEntranceTimeline();
        initCardMicroInteractions();
    }

    /**
     * 1. Three.js Ambient Interactive Background (Organic 3D Fluid/Blobs)
     * Thay vì hạt lấp lánh lộ liễu, tạo nền 3D ánh sáng hữu cơ biến đổi mềm mại theo chuột
     */
    function initAmbient3DBackground() {
        const canvas = document.getElementById("ambient-canvas");
        if (!canvas || typeof THREE === "undefined") return;

        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 0.1, 1000);
        camera.position.z = 80;

        const renderer = new THREE.WebGLRenderer({
            canvas: canvas,
            alpha: true,
            antialias: true,
            powerPreference: "high-performance"
        });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(Math.min(window.devicePixelRatio, 1.5)); // Tối ưu GPU

        // Nhóm các khối Organic Blobs
        const blobGroup = new THREE.Group();
        scene.add(blobGroup);

        // Ánh sáng Ambient & Điểm sáng di động
        const ambientLight = new THREE.AmbientLight(0xffffff, 0.85);
        scene.add(ambientLight);

        const pointLight1 = new THREE.PointLight(0x6366f1, 2.5, 300); // Indigo tinh tế
        pointLight1.position.set(30, 20, 40);
        scene.add(pointLight1);

        const pointLight2 = new THREE.PointLight(0x0ea5e9, 2.0, 300); // Sky blue
        pointLight2.position.set(-30, -20, 30);
        scene.add(pointLight2);

        const pointLight3 = new THREE.PointLight(0xf43f5e, 1.2, 250); // Muted rose
        pointLight3.position.set(0, 30, 20);
        scene.add(pointLight3);

        // Tạo 3 khối cầu Mesh với vật liệu tán xạ ánh sáng vật lý (Physical Material)
        const geometries = [
            new THREE.IcosahedronGeometry(22, 12),
            new THREE.IcosahedronGeometry(16, 10),
            new THREE.IcosahedronGeometry(18, 10)
        ];

        const materials = [
            new THREE.MeshStandardMaterial({
                color: 0xf8fafc,
                roughness: 0.2,
                metalness: 0.1,
                transparent: true,
                opacity: 0.85
            }),
            new THREE.MeshStandardMaterial({
                color: 0xe0e7ff,
                roughness: 0.3,
                metalness: 0.2,
                transparent: true,
                opacity: 0.75
            }),
            new THREE.MeshStandardMaterial({
                color: 0xf0fdf4,
                roughness: 0.25,
                metalness: 0.15,
                transparent: true,
                opacity: 0.8
            })
        ];

        const blobs = [];
        const initialPositions = [
            { x: -25, y: 10, z: -10 },
            { x: 30, y: -12, z: -15 },
            { x: 5, y: -20, z: -5 }
        ];

        for (let i = 0; i < 3; i++) {
            const mesh = new THREE.Mesh(geometries[i], materials[i]);
            mesh.position.set(initialPositions[i].x, initialPositions[i].y, initialPositions[i].z);
            blobGroup.add(mesh);
            blobs.push({
                mesh: mesh,
                baseX: initialPositions[i].x,
                baseY: initialPositions[i].y,
                speedX: 0.001 + i * 0.0006,
                speedY: 0.0008 + i * 0.0005,
                phase: i * 2.1
            });
        }

        // Tọa độ chuột với thuật toán làm mềm (Lerp dampening)
        let mouseX = 0, mouseY = 0;
        let targetMouseX = 0, targetMouseY = 0;

        window.addEventListener("pointermove", (e) => {
            targetMouseX = (e.clientX / window.innerWidth - 0.5) * 2;
            targetMouseY = -(e.clientY / window.innerHeight - 0.5) * 2;
        }, { passive: true });

        // Tối ưu tab background (dừng render khi người dùng chuyển tab)
        let isTabActive = true;
        document.addEventListener("visibilitychange", () => {
            isTabActive = !document.hidden;
        });

        // Animation Loop 60fps
        let clock = new THREE.Clock();
        function renderLoop() {
            requestAnimationFrame(renderLoop);
            if (!isTabActive) return;

            const elapsedTime = clock.getElapsedTime();

            // Lerp mượt tọa độ chuột
            mouseX += (targetMouseX - mouseX) * 0.04;
            mouseY += (targetMouseY - mouseY) * 0.04;

            // Di chuyển nhóm ánh sáng và khối theo tương tác chuột
            pointLight1.position.x = 30 + mouseX * 25;
            pointLight1.position.y = 20 + mouseY * 25;

            pointLight2.position.x = -30 - mouseX * 20;
            pointLight2.position.y = -20 - mouseY * 20;

            blobGroup.rotation.y = mouseX * 0.2 + elapsedTime * 0.03;
            blobGroup.rotation.x = -mouseY * 0.15;

            // Biến đổi vị trí hữu cơ nhẹ nhàng cho từng khối
            blobs.forEach((item, idx) => {
                const t = elapsedTime + item.phase;
                item.mesh.position.x = item.baseX + Math.sin(t * 0.7) * 4 + mouseX * (10 + idx * 4);
                item.mesh.position.y = item.baseY + Math.cos(t * 0.9) * 4 + mouseY * (8 + idx * 3);
                item.mesh.rotation.x += item.speedX;
                item.mesh.rotation.y += item.speedY;
            });

            renderer.render(scene, camera);
        }
        renderLoop();

        // Responsive Resize
        window.addEventListener("resize", () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        });
    }

    /**
     * 2. GSAP Timeline - Chuỗi xuất hiện tinh tế mang phong cách Editorial (Không bay lượn rẻ tiền)
     */
    function initEntranceTimeline() {
        if (typeof gsap === "undefined") return;

        const tl = gsap.timeline({
            defaults: {
                ease: "power3.out",
                duration: 0.8
            }
        });

        tl.from(".editorial-eyebrow", {
            opacity: 0,
            y: 12,
            duration: 0.6
        })
        .from(".editorial-hero-title", {
            opacity: 0,
            y: 20,
            duration: 0.75
        }, "-=0.35")
        .from(".editorial-hero-lead", {
            opacity: 0,
            y: 16,
            duration: 0.65
        }, "-=0.4")
        .from(".editorial-stats-item", {
            opacity: 0,
            y: 12,
            stagger: 0.08,
            duration: 0.5
        }, "-=0.3")
        .from(".editorial-card", {
            opacity: 0,
            y: 28,
            duration: 0.7,
            stagger: 0.08,
            ease: "power2.out"
        }, "-=0.3");
    }

    /**
     * 3. Micro-interactions: Hiệu ứng Hover thẻ sản phẩm chuẩn Senior Creative Developer
     * Chuẩn yêu cầu:
     * - y: -6
     * - box-shadow mượt mà
     * - scale ảnh bên trong: 1.05 (overflow: hidden)
     * - duration: 0.4s
     * - easing: power2.out
     */
    function initCardMicroInteractions() {
        if (typeof gsap === "undefined") return;

        const cards = document.querySelectorAll(".editorial-card");

        cards.forEach((card) => {
            const img = card.querySelector(".editorial-card-img");
            const arrow = card.querySelector(".card-action-arrow");
            const badge = card.querySelector(".card-badge");

            card.addEventListener("mouseenter", () => {
                // Thẻ nổi nhẹ lên y: -6, bóng đổ lan mịn
                gsap.to(card, {
                    y: -6,
                    boxShadow: "0 20px 40px -15px rgba(15, 23, 42, 0.12), 0 0 1px 1px rgba(15, 23, 42, 0.05)",
                    borderColor: "rgba(99, 102, 241, 0.25)",
                    duration: 0.4,
                    ease: "power2.out",
                    overwrite: "auto"
                });

                // Ảnh bên trong phóng nhẹ 5% (scale: 1.05)
                if (img) {
                    gsap.to(img, {
                        scale: 1.05,
                        duration: 0.4,
                        ease: "power2.out",
                        overwrite: "auto"
                    });
                }

                // Mũi tên tương tác vi mô xoay nhẹ góc 45 độ
                if (arrow) {
                    gsap.to(arrow, {
                        x: 2,
                        y: -2,
                        color: "#4f46e5",
                        duration: 0.3,
                        ease: "power2.out"
                    });
                }

                if (badge) {
                    gsap.to(badge, {
                        backgroundColor: "rgba(15, 23, 42, 0.9)",
                        color: "#ffffff",
                        duration: 0.3,
                        ease: "power2.out"
                    });
                }
            });

            card.addEventListener("mouseleave", () => {
                // Trở về trạng thái ban đầu mượt mà
                gsap.to(card, {
                    y: 0,
                    boxShadow: "0 4px 20px rgba(15, 23, 42, 0.04), 0 0 1px rgba(15, 23, 42, 0.08)",
                    borderColor: "rgba(226, 232, 240, 0.8)",
                    duration: 0.4,
                    ease: "power2.out",
                    overwrite: "auto"
                });

                if (img) {
                    gsap.to(img, {
                        scale: 1.0,
                        duration: 0.4,
                        ease: "power2.out",
                        overwrite: "auto"
                    });
                }

                if (arrow) {
                    gsap.to(arrow, {
                        x: 0,
                        y: 0,
                        color: "#94a3b8",
                        duration: 0.3,
                        ease: "power2.out"
                    });
                }

                if (badge) {
                    gsap.to(badge, {
                        backgroundColor: "rgba(255, 255, 255, 0.85)",
                        color: "#475569",
                        duration: 0.3,
                        ease: "power2.out"
                    });
                }
            });
        });
    }
})();

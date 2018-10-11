
q4:     file format elf32-i386


Disassembly of section .init:

08048424 <_init>:
 8048424:	55                   	push   ebp
 8048425:	89 e5                	mov    ebp,esp
 8048427:	53                   	push   ebx
 8048428:	83 ec 04             	sub    esp,0x4
 804842b:	e8 00 00 00 00       	call   8048430 <_init+0xc>
 8048430:	5b                   	pop    ebx
 8048431:	81 c3 a0 15 00 00    	add    ebx,0x15a0
 8048437:	8b 93 fc ff ff ff    	mov    edx,DWORD PTR [ebx-0x4]
 804843d:	85 d2                	test   edx,edx
 804843f:	74 05                	je     8048446 <_init+0x22>
 8048441:	e8 1e 00 00 00       	call   8048464 <__gmon_start__@plt>
 8048446:	e8 45 01 00 00       	call   8048590 <frame_dummy>
 804844b:	e8 00 03 00 00       	call   8048750 <__do_global_ctors_aux>
 8048450:	58                   	pop    eax
 8048451:	5b                   	pop    ebx
 8048452:	c9                   	leave  
 8048453:	c3                   	ret    

Disassembly of section .plt:

08048454 <.plt>:
 8048454:	ff 35 d4 99 04 08    	push   DWORD PTR ds:0x80499d4
 804845a:	ff 25 d8 99 04 08    	jmp    DWORD PTR ds:0x80499d8
 8048460:	00 00                	add    BYTE PTR [eax],al
	...

08048464 <__gmon_start__@plt>:
 8048464:	ff 25 dc 99 04 08    	jmp    DWORD PTR ds:0x80499dc
 804846a:	68 00 00 00 00       	push   0x0
 804846f:	e9 e0 ff ff ff       	jmp    8048454 <.plt>

08048474 <putchar@plt>:
 8048474:	ff 25 e0 99 04 08    	jmp    DWORD PTR ds:0x80499e0
 804847a:	68 08 00 00 00       	push   0x8
 804847f:	e9 d0 ff ff ff       	jmp    8048454 <.plt>

08048484 <fgets@plt>:
 8048484:	ff 25 e4 99 04 08    	jmp    DWORD PTR ds:0x80499e4
 804848a:	68 10 00 00 00       	push   0x10
 804848f:	e9 c0 ff ff ff       	jmp    8048454 <.plt>

08048494 <__libc_start_main@plt>:
 8048494:	ff 25 e8 99 04 08    	jmp    DWORD PTR ds:0x80499e8
 804849a:	68 18 00 00 00       	push   0x18
 804849f:	e9 b0 ff ff ff       	jmp    8048454 <.plt>

080484a4 <fopen@plt>:
 80484a4:	ff 25 ec 99 04 08    	jmp    DWORD PTR ds:0x80499ec
 80484aa:	68 20 00 00 00       	push   0x20
 80484af:	e9 a0 ff ff ff       	jmp    8048454 <.plt>

080484b4 <printf@plt>:
 80484b4:	ff 25 f0 99 04 08    	jmp    DWORD PTR ds:0x80499f0
 80484ba:	68 28 00 00 00       	push   0x28
 80484bf:	e9 90 ff ff ff       	jmp    8048454 <.plt>

080484c4 <puts@plt>:
 80484c4:	ff 25 f4 99 04 08    	jmp    DWORD PTR ds:0x80499f4
 80484ca:	68 30 00 00 00       	push   0x30
 80484cf:	e9 80 ff ff ff       	jmp    8048454 <.plt>

080484d4 <__gxx_personality_v0@plt>:
 80484d4:	ff 25 f8 99 04 08    	jmp    DWORD PTR ds:0x80499f8
 80484da:	68 38 00 00 00       	push   0x38
 80484df:	e9 70 ff ff ff       	jmp    8048454 <.plt>

080484e4 <strcmp@plt>:
 80484e4:	ff 25 fc 99 04 08    	jmp    DWORD PTR ds:0x80499fc
 80484ea:	68 40 00 00 00       	push   0x40
 80484ef:	e9 60 ff ff ff       	jmp    8048454 <.plt>

Disassembly of section .text:

08048500 <_start>:
 8048500:	31 ed                	xor    ebp,ebp
 8048502:	5e                   	pop    esi
 8048503:	89 e1                	mov    ecx,esp
 8048505:	83 e4 f0             	and    esp,0xfffffff0
 8048508:	50                   	push   eax
 8048509:	54                   	push   esp
 804850a:	52                   	push   edx
 804850b:	68 e0 86 04 08       	push   0x80486e0
 8048510:	68 f0 86 04 08       	push   0x80486f0
 8048515:	51                   	push   ecx
 8048516:	56                   	push   esi
 8048517:	68 b4 85 04 08       	push   0x80485b4
 804851c:	e8 73 ff ff ff       	call   8048494 <__libc_start_main@plt>
 8048521:	f4                   	hlt    
 8048522:	90                   	nop
 8048523:	90                   	nop
 8048524:	90                   	nop
 8048525:	90                   	nop
 8048526:	90                   	nop
 8048527:	90                   	nop
 8048528:	90                   	nop
 8048529:	90                   	nop
 804852a:	90                   	nop
 804852b:	90                   	nop
 804852c:	90                   	nop
 804852d:	90                   	nop
 804852e:	90                   	nop
 804852f:	90                   	nop

08048530 <__do_global_dtors_aux>:
 8048530:	55                   	push   ebp
 8048531:	89 e5                	mov    ebp,esp
 8048533:	53                   	push   ebx
 8048534:	8d 64 24 fc          	lea    esp,[esp-0x4]
 8048538:	80 3d 08 9a 04 08 00 	cmp    BYTE PTR ds:0x8049a08,0x0
 804853f:	75 3e                	jne    804857f <__do_global_dtors_aux+0x4f>
 8048541:	bb e4 98 04 08       	mov    ebx,0x80498e4
 8048546:	a1 0c 9a 04 08       	mov    eax,ds:0x8049a0c
 804854b:	81 eb e0 98 04 08    	sub    ebx,0x80498e0
 8048551:	c1 fb 02             	sar    ebx,0x2
 8048554:	83 eb 01             	sub    ebx,0x1
 8048557:	39 d8                	cmp    eax,ebx
 8048559:	73 1d                	jae    8048578 <__do_global_dtors_aux+0x48>
 804855b:	90                   	nop
 804855c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
 8048560:	83 c0 01             	add    eax,0x1
 8048563:	a3 0c 9a 04 08       	mov    ds:0x8049a0c,eax
 8048568:	ff 14 85 e0 98 04 08 	call   DWORD PTR [eax*4+0x80498e0]
 804856f:	a1 0c 9a 04 08       	mov    eax,ds:0x8049a0c
 8048574:	39 d8                	cmp    eax,ebx
 8048576:	72 e8                	jb     8048560 <__do_global_dtors_aux+0x30>
 8048578:	c6 05 08 9a 04 08 01 	mov    BYTE PTR ds:0x8049a08,0x1
 804857f:	8d 64 24 04          	lea    esp,[esp+0x4]
 8048583:	5b                   	pop    ebx
 8048584:	5d                   	pop    ebp
 8048585:	c3                   	ret    
 8048586:	8d 76 00             	lea    esi,[esi+0x0]
 8048589:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

08048590 <frame_dummy>:
 8048590:	55                   	push   ebp
 8048591:	89 e5                	mov    ebp,esp
 8048593:	8d 64 24 e8          	lea    esp,[esp-0x18]
 8048597:	a1 e8 98 04 08       	mov    eax,ds:0x80498e8
 804859c:	85 c0                	test   eax,eax
 804859e:	74 12                	je     80485b2 <frame_dummy+0x22>
 80485a0:	b8 00 00 00 00       	mov    eax,0x0
 80485a5:	85 c0                	test   eax,eax
 80485a7:	74 09                	je     80485b2 <frame_dummy+0x22>
 80485a9:	c7 04 24 e8 98 04 08 	mov    DWORD PTR [esp],0x80498e8
 80485b0:	ff d0                	call   eax
 80485b2:	c9                   	leave  
 80485b3:	c3                   	ret    

080485b4 <main>:
 80485b4:	55                   	push   ebp
 80485b5:	89 e5                	mov    ebp,esp
 80485b7:	83 e4 f0             	and    esp,0xfffffff0
 80485ba:	81 ec 20 04 00 00    	sub    esp,0x420
 80485c0:	c7 04 24 a4 87 04 08 	mov    DWORD PTR [esp],0x80487a4
 80485c7:	e8 f8 fe ff ff       	call   80484c4 <puts@plt>
 80485cc:	a1 04 9a 04 08       	mov    eax,ds:0x8049a04
 80485d1:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 80485d5:	c7 44 24 04 00 04 00 	mov    DWORD PTR [esp+0x4],0x400
 80485dc:	00 
 80485dd:	8d 44 24 18          	lea    eax,[esp+0x18]
 80485e1:	89 04 24             	mov    DWORD PTR [esp],eax
 80485e4:	e8 9b fe ff ff       	call   8048484 <fgets@plt>
 80485e9:	c7 04 24 b6 87 04 08 	mov    DWORD PTR [esp],0x80487b6
 80485f0:	e8 bf fe ff ff       	call   80484b4 <printf@plt>
 80485f5:	8d 44 24 18          	lea    eax,[esp+0x18]
 80485f9:	89 04 24             	mov    DWORD PTR [esp],eax
 80485fc:	e8 b3 fe ff ff       	call   80484b4 <printf@plt>
 8048601:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
 8048608:	e8 67 fe ff ff       	call   8048474 <putchar@plt>
 804860d:	c7 84 24 18 04 00 00 	mov    DWORD PTR [esp+0x418],0x1
 8048614:	01 00 00 00 
 8048618:	eb 67                	jmp    8048681 <main+0xcd>
 804861a:	c7 04 24 bb 87 04 08 	mov    DWORD PTR [esp],0x80487bb
 8048621:	e8 9e fe ff ff       	call   80484c4 <puts@plt>
 8048626:	a1 04 9a 04 08       	mov    eax,ds:0x8049a04
 804862b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 804862f:	c7 44 24 04 00 04 00 	mov    DWORD PTR [esp+0x4],0x400
 8048636:	00 
 8048637:	8d 44 24 18          	lea    eax,[esp+0x18]
 804863b:	89 04 24             	mov    DWORD PTR [esp],eax
 804863e:	e8 41 fe ff ff       	call   8048484 <fgets@plt>
 8048643:	85 c0                	test   eax,eax
 8048645:	0f 94 c0             	sete   al
 8048648:	84 c0                	test   al,al
 804864a:	74 0a                	je     8048656 <main+0xa2>
 804864c:	b8 00 00 00 00       	mov    eax,0x0
 8048651:	e9 86 00 00 00       	jmp    80486dc <main+0x128>
 8048656:	c7 44 24 04 d1 87 04 	mov    DWORD PTR [esp+0x4],0x80487d1
 804865d:	08 
 804865e:	8d 44 24 18          	lea    eax,[esp+0x18]
 8048662:	89 04 24             	mov    DWORD PTR [esp],eax
 8048665:	e8 7a fe ff ff       	call   80484e4 <strcmp@plt>
 804866a:	85 c0                	test   eax,eax
 804866c:	75 13                	jne    8048681 <main+0xcd>
 804866e:	c7 04 24 d5 87 04 08 	mov    DWORD PTR [esp],0x80487d5
 8048675:	e8 4a fe ff ff       	call   80484c4 <puts@plt>
 804867a:	b8 00 00 00 00       	mov    eax,0x0
 804867f:	eb 5b                	jmp    80486dc <main+0x128>
 8048681:	8b 84 24 18 04 00 00 	mov    eax,DWORD PTR [esp+0x418]
 8048688:	85 c0                	test   eax,eax
 804868a:	0f 95 c0             	setne  al
 804868d:	84 c0                	test   al,al
 804868f:	75 89                	jne    804861a <main+0x66>
 8048691:	c7 44 24 04 e6 87 04 	mov    DWORD PTR [esp+0x4],0x80487e6
 8048698:	08 
 8048699:	c7 04 24 e8 87 04 08 	mov    DWORD PTR [esp],0x80487e8
 80486a0:	e8 ff fd ff ff       	call   80484a4 <fopen@plt>
 80486a5:	89 84 24 1c 04 00 00 	mov    DWORD PTR [esp+0x41c],eax
 80486ac:	8b 84 24 1c 04 00 00 	mov    eax,DWORD PTR [esp+0x41c]
 80486b3:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 80486b7:	c7 44 24 04 00 04 00 	mov    DWORD PTR [esp+0x4],0x400
 80486be:	00 
 80486bf:	8d 44 24 18          	lea    eax,[esp+0x18]
 80486c3:	89 04 24             	mov    DWORD PTR [esp],eax
 80486c6:	e8 b9 fd ff ff       	call   8048484 <fgets@plt>
 80486cb:	8d 44 24 18          	lea    eax,[esp+0x18]
 80486cf:	89 04 24             	mov    DWORD PTR [esp],eax
 80486d2:	e8 dd fd ff ff       	call   80484b4 <printf@plt>
 80486d7:	b8 00 00 00 00       	mov    eax,0x0
 80486dc:	c9                   	leave  
 80486dd:	c3                   	ret    
 80486de:	90                   	nop
 80486df:	90                   	nop

080486e0 <__libc_csu_fini>:
 80486e0:	55                   	push   ebp
 80486e1:	89 e5                	mov    ebp,esp
 80486e3:	5d                   	pop    ebp
 80486e4:	c3                   	ret    
 80486e5:	66 66 2e 0f 1f 84 00 	data16 nop WORD PTR cs:[eax+eax*1+0x0]
 80486ec:	00 00 00 00 

080486f0 <__libc_csu_init>:
 80486f0:	55                   	push   ebp
 80486f1:	89 e5                	mov    ebp,esp
 80486f3:	57                   	push   edi
 80486f4:	56                   	push   esi
 80486f5:	53                   	push   ebx
 80486f6:	e8 4f 00 00 00       	call   804874a <__i686.get_pc_thunk.bx>
 80486fb:	81 c3 d5 12 00 00    	add    ebx,0x12d5
 8048701:	83 ec 1c             	sub    esp,0x1c
 8048704:	e8 1b fd ff ff       	call   8048424 <_init>
 8048709:	8d bb 08 ff ff ff    	lea    edi,[ebx-0xf8]
 804870f:	8d 83 08 ff ff ff    	lea    eax,[ebx-0xf8]
 8048715:	29 c7                	sub    edi,eax
 8048717:	c1 ff 02             	sar    edi,0x2
 804871a:	85 ff                	test   edi,edi
 804871c:	74 24                	je     8048742 <__libc_csu_init+0x52>
 804871e:	31 f6                	xor    esi,esi
 8048720:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 8048723:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 8048727:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 804872a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 804872e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 8048731:	89 04 24             	mov    DWORD PTR [esp],eax
 8048734:	ff 94 b3 08 ff ff ff 	call   DWORD PTR [ebx+esi*4-0xf8]
 804873b:	83 c6 01             	add    esi,0x1
 804873e:	39 fe                	cmp    esi,edi
 8048740:	72 de                	jb     8048720 <__libc_csu_init+0x30>
 8048742:	83 c4 1c             	add    esp,0x1c
 8048745:	5b                   	pop    ebx
 8048746:	5e                   	pop    esi
 8048747:	5f                   	pop    edi
 8048748:	5d                   	pop    ebp
 8048749:	c3                   	ret    

0804874a <__i686.get_pc_thunk.bx>:
 804874a:	8b 1c 24             	mov    ebx,DWORD PTR [esp]
 804874d:	c3                   	ret    
 804874e:	90                   	nop
 804874f:	90                   	nop

08048750 <__do_global_ctors_aux>:
 8048750:	55                   	push   ebp
 8048751:	89 e5                	mov    ebp,esp
 8048753:	53                   	push   ebx
 8048754:	8d 64 24 fc          	lea    esp,[esp-0x4]
 8048758:	a1 d8 98 04 08       	mov    eax,ds:0x80498d8
 804875d:	83 f8 ff             	cmp    eax,0xffffffff
 8048760:	74 12                	je     8048774 <__do_global_ctors_aux+0x24>
 8048762:	bb d8 98 04 08       	mov    ebx,0x80498d8
 8048767:	90                   	nop
 8048768:	8d 5b fc             	lea    ebx,[ebx-0x4]
 804876b:	ff d0                	call   eax
 804876d:	8b 03                	mov    eax,DWORD PTR [ebx]
 804876f:	83 f8 ff             	cmp    eax,0xffffffff
 8048772:	75 f4                	jne    8048768 <__do_global_ctors_aux+0x18>
 8048774:	8d 64 24 04          	lea    esp,[esp+0x4]
 8048778:	5b                   	pop    ebx
 8048779:	5d                   	pop    ebp
 804877a:	c3                   	ret    
 804877b:	90                   	nop

Disassembly of section .fini:

0804877c <_fini>:
 804877c:	55                   	push   ebp
 804877d:	89 e5                	mov    ebp,esp
 804877f:	53                   	push   ebx
 8048780:	83 ec 04             	sub    esp,0x4
 8048783:	e8 00 00 00 00       	call   8048788 <_fini+0xc>
 8048788:	5b                   	pop    ebx
 8048789:	81 c3 48 12 00 00    	add    ebx,0x1248
 804878f:	e8 9c fd ff ff       	call   8048530 <__do_global_dtors_aux>
 8048794:	59                   	pop    ecx
 8048795:	5b                   	pop    ebx
 8048796:	c9                   	leave  
 8048797:	c3                   	ret    

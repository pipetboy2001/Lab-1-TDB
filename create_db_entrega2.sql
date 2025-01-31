PGDMP         :            
    z           voluntariado    15.0    15.0 -    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    23501    voluntariado    DATABASE     n   CREATE DATABASE voluntariado WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE voluntariado;
                postgres    false                        3079    23502    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false            �           0    0    EXTENSION postgis    COMMENT     ^   COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';
                        false    2            �            1259    24548    region    TABLE     w  CREATE TABLE public.region (
    gid integer NOT NULL,
    nom_reg character varying(50),
    nom_prov character varying(20),
    cod_com character varying(5),
    nom_com character varying(30),
    cod_regi numeric,
    superficie numeric,
    poblac02 integer,
    pobl2010 integer,
    shape_leng numeric,
    shape_area numeric,
    geom public.geometry(MultiPolygon)
);
    DROP TABLE public.region;
       public         heap    postgres    false    2    2    2    2    2    2    2    2            �            1259    24553    division_regional_gid_seq    SEQUENCE     �   CREATE SEQUENCE public.division_regional_gid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.division_regional_gid_seq;
       public          postgres    false    220            �           0    0    division_regional_gid_seq    SEQUENCE OWNED BY     L   ALTER SEQUENCE public.division_regional_gid_seq OWNED BY public.region.gid;
          public          postgres    false    221            �            1259    24554    eme_habilidad    TABLE     �   CREATE TABLE public.eme_habilidad (
    id numeric(8,0) NOT NULL,
    id_emergencia numeric(6,0),
    id_habilidad numeric(4,0)
);
 !   DROP TABLE public.eme_habilidad;
       public         heap    postgres    false            �            1259    24557 
   emergencia    TABLE       CREATE TABLE public.emergencia (
    id numeric(6,0) NOT NULL,
    nombre character varying(100),
    descrip character varying(400),
    finicio date,
    ffin date,
    id_institucion numeric(4,0),
    longitud numeric,
    latitud numeric,
    geom public.geometry(Point,4326)
);
    DROP TABLE public.emergencia;
       public         heap    postgres    false    2    2    2    2    2    2    2    2            �            1259    24562    estado_tarea    TABLE     f   CREATE TABLE public.estado_tarea (
    id numeric(2,0) NOT NULL,
    descrip character varying(20)
);
     DROP TABLE public.estado_tarea;
       public         heap    postgres    false            �            1259    24565 	   habilidad    TABLE     d   CREATE TABLE public.habilidad (
    id numeric(4,0) NOT NULL,
    descrip character varying(100)
);
    DROP TABLE public.habilidad;
       public         heap    postgres    false            �            1259    24568    institucion    TABLE     �   CREATE TABLE public.institucion (
    id numeric(4,0) NOT NULL,
    nombre character varying(100),
    descrip character varying(400)
);
    DROP TABLE public.institucion;
       public         heap    postgres    false            �            1259    24573    ranking    TABLE     �   CREATE TABLE public.ranking (
    id numeric(8,0) NOT NULL,
    id_voluntario numeric(8,0),
    id_tarea numeric(8,0),
    puntaje numeric(3,0),
    flg_invitado numeric(1,0),
    flg_participa numeric(1,0)
);
    DROP TABLE public.ranking;
       public         heap    postgres    false            �           0    0    TABLE ranking    COMMENT     u   COMMENT ON TABLE public.ranking IS 'los flgInvitado, flgParticipa 1 si la respuesta es si, 2 si la respuesta es no';
          public          postgres    false    227            �            1259    24576    tarea    TABLE     v  CREATE TABLE public.tarea (
    id numeric(8,0) NOT NULL,
    nombre character varying(60),
    descrip character varying(300),
    cant_vol_requeridos numeric(4,0),
    cant_vol_inscritos numeric(4,0),
    id_emergencia numeric(6,0),
    finicio date,
    ffin date,
    id_estado numeric(2,0),
    longitud numeric,
    latitud numeric,
    geom public.geometry(Point)
);
    DROP TABLE public.tarea;
       public         heap    postgres    false    2    2    2    2    2    2    2    2            �            1259    24581    requeridos_emergencia    VIEW     '  CREATE VIEW public.requeridos_emergencia AS
 SELECT emergencia.id AS emergencia,
    sum(tarea.cant_vol_requeridos) AS requeridos
   FROM public.tarea,
    public.emergencia
  WHERE (tarea.id_emergencia = emergencia.id)
  GROUP BY emergencia.id
  ORDER BY (sum(tarea.cant_vol_requeridos)) DESC;
 (   DROP VIEW public.requeridos_emergencia;
       public          postgres    false    228    223    228            �            1259    24585    tarea_habilidad    TABLE     }   CREATE TABLE public.tarea_habilidad (
    id numeric(8,0) NOT NULL,
    id_emehab numeric(8,0),
    id_tarea numeric(8,0)
);
 #   DROP TABLE public.tarea_habilidad;
       public         heap    postgres    false            �            1259    24588    tareas_emergencia    VIEW     �   CREATE VIEW public.tareas_emergencia AS
 SELECT tarea.id_emergencia,
    tarea.nombre,
    tarea.id AS id_tarea
   FROM public.tarea,
    public.emergencia
  WHERE ((tarea.id_emergencia = (1)::numeric) AND (tarea.id_emergencia = emergencia.id));
 $   DROP VIEW public.tareas_emergencia;
       public          postgres    false    228    228    228    223            �            1259    24592    vol_habilidad    TABLE     �   CREATE TABLE public.vol_habilidad (
    id numeric(8,0) NOT NULL,
    id_voluntario numeric(8,0),
    id_habilidad numeric(8,0)
);
 !   DROP TABLE public.vol_habilidad;
       public         heap    postgres    false            �            1259    24595 
   voluntario    TABLE     z   CREATE TABLE public.voluntario (
    id numeric(8,0) NOT NULL,
    nombre character varying(100),
    fnacimiento date
);
    DROP TABLE public.voluntario;
       public         heap    postgres    false                       2604    24598 
   region gid    DEFAULT     s   ALTER TABLE ONLY public.region ALTER COLUMN gid SET DEFAULT nextval('public.division_regional_gid_seq'::regclass);
 9   ALTER TABLE public.region ALTER COLUMN gid DROP DEFAULT;
       public          postgres    false    221    220            !           2606    24620    region division_regional_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.region
    ADD CONSTRAINT division_regional_pkey PRIMARY KEY (gid);
 G   ALTER TABLE ONLY public.region DROP CONSTRAINT division_regional_pkey;
       public            postgres    false    220            #           2606    24622     eme_habilidad eme_habilidad_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.eme_habilidad
    ADD CONSTRAINT eme_habilidad_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.eme_habilidad DROP CONSTRAINT eme_habilidad_pkey;
       public            postgres    false    222            %           2606    24624    emergencia emergencia_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.emergencia
    ADD CONSTRAINT emergencia_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.emergencia DROP CONSTRAINT emergencia_pkey;
       public            postgres    false    223            '           2606    24626    estado_tarea estado_tarea_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.estado_tarea
    ADD CONSTRAINT estado_tarea_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.estado_tarea DROP CONSTRAINT estado_tarea_pkey;
       public            postgres    false    224            )           2606    24628    habilidad habilidad_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.habilidad
    ADD CONSTRAINT habilidad_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.habilidad DROP CONSTRAINT habilidad_pkey;
       public            postgres    false    225            +           2606    24630    institucion institucion_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.institucion
    ADD CONSTRAINT institucion_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.institucion DROP CONSTRAINT institucion_pkey;
       public            postgres    false    226            -           2606    24632    ranking ranking_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.ranking
    ADD CONSTRAINT ranking_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.ranking DROP CONSTRAINT ranking_pkey;
       public            postgres    false    227            1           2606    24634 $   tarea_habilidad tarea_habilidad_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.tarea_habilidad
    ADD CONSTRAINT tarea_habilidad_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.tarea_habilidad DROP CONSTRAINT tarea_habilidad_pkey;
       public            postgres    false    230            /           2606    24636    tarea tarea_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.tarea
    ADD CONSTRAINT tarea_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.tarea DROP CONSTRAINT tarea_pkey;
       public            postgres    false    228            3           2606    24638     vol_habilidad vol_habilidad_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.vol_habilidad
    ADD CONSTRAINT vol_habilidad_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.vol_habilidad DROP CONSTRAINT vol_habilidad_pkey;
       public            postgres    false    232            5           2606    24640    voluntario voluntario_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.voluntario
    ADD CONSTRAINT voluntario_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.voluntario DROP CONSTRAINT voluntario_pkey;
       public            postgres    false    233            6           2606    24641 "   eme_habilidad fk_emehab_emergencia    FK CONSTRAINT     �   ALTER TABLE ONLY public.eme_habilidad
    ADD CONSTRAINT fk_emehab_emergencia FOREIGN KEY (id_emergencia) REFERENCES public.emergencia(id);
 L   ALTER TABLE ONLY public.eme_habilidad DROP CONSTRAINT fk_emehab_emergencia;
       public          postgres    false    4389    223    222            7           2606    24646 !   eme_habilidad fk_emehab_habilidad    FK CONSTRAINT     �   ALTER TABLE ONLY public.eme_habilidad
    ADD CONSTRAINT fk_emehab_habilidad FOREIGN KEY (id_habilidad) REFERENCES public.habilidad(id);
 K   ALTER TABLE ONLY public.eme_habilidad DROP CONSTRAINT fk_emehab_habilidad;
       public          postgres    false    4393    222    225            8           2606    24651 $   emergencia fk_emergencia_institucion    FK CONSTRAINT     �   ALTER TABLE ONLY public.emergencia
    ADD CONSTRAINT fk_emergencia_institucion FOREIGN KEY (id_institucion) REFERENCES public.institucion(id);
 N   ALTER TABLE ONLY public.emergencia DROP CONSTRAINT fk_emergencia_institucion;
       public          postgres    false    223    226    4395            9           2606    24656    ranking fk_ranking_tarea    FK CONSTRAINT     x   ALTER TABLE ONLY public.ranking
    ADD CONSTRAINT fk_ranking_tarea FOREIGN KEY (id_tarea) REFERENCES public.tarea(id);
 B   ALTER TABLE ONLY public.ranking DROP CONSTRAINT fk_ranking_tarea;
       public          postgres    false    228    4399    227            :           2606    24661    ranking fk_ranking_voluntario    FK CONSTRAINT     �   ALTER TABLE ONLY public.ranking
    ADD CONSTRAINT fk_ranking_voluntario FOREIGN KEY (id_voluntario) REFERENCES public.voluntario(id);
 G   ALTER TABLE ONLY public.ranking DROP CONSTRAINT fk_ranking_voluntario;
       public          postgres    false    227    233    4405            ;           2606    24666    tarea fk_tarea_emergencia    FK CONSTRAINT     �   ALTER TABLE ONLY public.tarea
    ADD CONSTRAINT fk_tarea_emergencia FOREIGN KEY (id_emergencia) REFERENCES public.emergencia(id);
 C   ALTER TABLE ONLY public.tarea DROP CONSTRAINT fk_tarea_emergencia;
       public          postgres    false    223    4389    228            <           2606    24671    tarea fk_tarea_estadotarea    FK CONSTRAINT     �   ALTER TABLE ONLY public.tarea
    ADD CONSTRAINT fk_tarea_estadotarea FOREIGN KEY (id_estado) REFERENCES public.estado_tarea(id);
 D   ALTER TABLE ONLY public.tarea DROP CONSTRAINT fk_tarea_estadotarea;
       public          postgres    false    224    4391    228            =           2606    24676 "   tarea_habilidad fk_tareahab_emehab    FK CONSTRAINT     �   ALTER TABLE ONLY public.tarea_habilidad
    ADD CONSTRAINT fk_tareahab_emehab FOREIGN KEY (id_emehab) REFERENCES public.eme_habilidad(id);
 L   ALTER TABLE ONLY public.tarea_habilidad DROP CONSTRAINT fk_tareahab_emehab;
       public          postgres    false    222    4387    230            >           2606    24681 !   tarea_habilidad fk_tareahab_tarea    FK CONSTRAINT     �   ALTER TABLE ONLY public.tarea_habilidad
    ADD CONSTRAINT fk_tareahab_tarea FOREIGN KEY (id_tarea) REFERENCES public.tarea(id);
 K   ALTER TABLE ONLY public.tarea_habilidad DROP CONSTRAINT fk_tareahab_tarea;
       public          postgres    false    228    4399    230            ?           2606    24686 !   vol_habilidad fk_volhab_habilidad    FK CONSTRAINT     �   ALTER TABLE ONLY public.vol_habilidad
    ADD CONSTRAINT fk_volhab_habilidad FOREIGN KEY (id_habilidad) REFERENCES public.habilidad(id);
 K   ALTER TABLE ONLY public.vol_habilidad DROP CONSTRAINT fk_volhab_habilidad;
       public          postgres    false    4393    225    232            @           2606    24691 "   vol_habilidad fk_volhab_voluntario    FK CONSTRAINT     �   ALTER TABLE ONLY public.vol_habilidad
    ADD CONSTRAINT fk_volhab_voluntario FOREIGN KEY (id_voluntario) REFERENCES public.voluntario(id);
 L   ALTER TABLE ONLY public.vol_habilidad DROP CONSTRAINT fk_volhab_voluntario;
       public          postgres    false    232    4405    233           
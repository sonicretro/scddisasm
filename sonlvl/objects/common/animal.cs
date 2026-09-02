using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.Common
{
	public class Animal : ObjectDefinition
	{
		private struct AnimalData
		{
			public string name;
			public Sprite img;
			public int depth;

			public AnimalData(string name, Sprite img, bool x_flip, int depth)
			{
				this.name = name;
				this.img = new Sprite(img, x_flip, false);
				this.depth = depth;
			}
		}

		private AnimalData[] animals;

		public override void Init(ObjectData data)
		{
			byte[] art_file;
			animals = new AnimalData[2];

			switch (LevelData.Level.Zone)
			{
				case 0:
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						"Flicky",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/animal_1.asm", 0, 0, true),
						true, 4);
					animals[1] = new AnimalData(
						"Squirrel",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/animal_2.asm", 0, 0, false),
						false, 0);
					break;

				case 1:
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r3/animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						"Canary",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r3/animal_1.asm", 0, 0, true),
						true, 1);
					animals[1] = new AnimalData(
						"Rabbit",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r3/animal_2.asm", 0, 0, false),
						false, 0);
					break;

				case 2:
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r4/animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						"Red Fish",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r4/animal_1.asm", 0, 0, false),
						false, 5);
					animals[1] = new AnimalData(
						"Green Fish",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r4/animal_2.asm", 0, 1, false),
						false, 5);
					break;

				case 3:
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r5/animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						"Flicky",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r5/animal_1.asm", 0, 0, true),
						true, 4);
					animals[1] = new AnimalData(
						"Squirrel",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r5/animal_2.asm", 0, 0, false),
						false, 0);
					break;

				case 4:
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r6/animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						"Swallow",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r6/animal_1.asm", 0, 0, true),
						true, 1);
					animals[1] = new AnimalData(
						"Penguin",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r6/animal_2.asm", 0, 0, false),
						false, 0);
					break;
					
				case 5:
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r7/animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						"Canary",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r7/animal_1.asm", 0, 0, false),
						true, 0);
					animals[1] = new AnimalData(
						"Rabbit",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r7/animal_2.asm", 0, 0, false),
						false, 0);
					break;

				case 6:
					art_file = ObjectHelper.OpenArtFile("../src/gfx/r8/animals.nem", CompressionType.Nemesis);
					animals[0] = new AnimalData(
						"Dove",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r8/animal_1.asm", 0, 0, false),
						true, 0);
					animals[1] = new AnimalData(
						"Sheep",
						ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r8/animal_2.asm", 0, 0, false),
						false, 0);
					break;
			}
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new byte[] { 0, 1 }); }
		}

		public override string Name
		{
			get { return "Animal"; }
		}

		public override bool RememberState
		{
			get { return false; }
		}

		public override string SubtypeName(byte subtype)
		{
			return animals[subtype].name;
		}

		public override Sprite Image
		{
			get { return animals[0].img; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			subtype &= 0x7F;
			if (subtype < animals.Length)
				return animals[subtype].img;
			return ObjectHelper.UnknownObject;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			bool x_flip = false;
			bool y_flip = false;
			if ((obj.SubType & 0x7F) == 0 || LevelData.Level.Zone == 2)
			{
				x_flip = obj.XFlip;
				y_flip = obj.YFlip;
			}
			return new Sprite(SubtypeImage(obj.SubType), x_flip, y_flip);
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			int subtype = obj.SubType & 0x7F;
			if (subtype < animals.Length)
				return animals[subtype].depth;
			return 0;
		}

		public override bool GetDebug(ObjectEntry obj)
		{
			return !LevelData.Level.GoodFuture;
		}
	}
}
